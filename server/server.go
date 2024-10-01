package server

import (
	"database/sql"
	"log"
	"net/http"
	"project/food-delivery/config"
	"project/food-delivery/handler"
	"project/food-delivery/middleware"
	postgres "project/food-delivery/repository/db"
	"project/food-delivery/service"
	"project/food-delivery/util"
)

func Start(cfg *config.Config) {
	// Set up PostgreSQL connection
	db, err := sql.Open("postgres", cfg.DBConnStr())
	if err != nil {
		log.Fatalf("error connecting to the database: %v", err)
	}
	defer db.Close()

	// Configure connection pooling
	db.SetMaxOpenConns(cfg.DBMaxOpenConns)
	db.SetMaxIdleConns(cfg.DBMaxIdleConns)

	// Repositories and services initialization
	supplierRepo := postgres.NewSupplierDbRepository(db)
	supplierService := service.NewSupplierService(supplierRepo)
	menuRepo := postgres.NewMenuItemRepository(db)
	menuService := service.NewMenuItemService(menuRepo, supplierRepo)
	typeRepo := postgres.NewTypeRepository(db)
	typeService := service.NewTypeRepository(typeRepo)
	orderRepo := postgres.NewOrderRepository(db)
	orderService := service.NewOrderService(orderRepo)
	userRepo := postgres.NewUserRepository(db)
	userService := service.NewUserService(userRepo)

	tokenService := service.NewTokenService(cfg)

	//update price and suppliers
	go menuService.PriceAndSupplierUpdater(supplierService)

	//Handlers
	userHandler := handler.NewUserHandler(userService, orderService, cfg)
	authHandler := handler.NewAuthHandler(cfg)

	//Routes
	mux := http.NewServeMux()

	// unprotected routes
	mux.HandleFunc("GET /api/suppliers", handler.GetAllSuppliersHandler(supplierService))
	mux.HandleFunc("GET /api/suppliers/{id}", handler.GetSupplierByIdHandler(supplierService))
	mux.HandleFunc("GET /api/suppliers/{id}/menus", handler.GetMenuItemBySupplierIdHandler(menuService, supplierService))
	mux.HandleFunc("GET /api/suppliers/{id}/categories", handler.GetSupplierCategoriesHandler(supplierService))
	mux.HandleFunc("GET /api/categories", handler.GetAllTypeHandler(typeService))
	mux.HandleFunc("GET /api/categories/suppliers/{category}", handler.GetSupplierByMenuType(supplierService))
	mux.HandleFunc("POST /api/user/login", userHandler.LoginHandler())
	mux.HandleFunc("POST /api/user/signup", userHandler.InsertUserHandler())

	// protected routes
	mux.Handle("POST /api/order", middleware.AuthMiddleware(tokenService, http.HandlerFunc(handler.CreateOrder(orderService))))
	mux.Handle("GET /api/order/{id}", middleware.AuthMiddleware(tokenService, handler.GetOrderDetailsById(orderService)))
	mux.Handle("GET /api/user/profile", middleware.AuthMiddleware(tokenService, http.HandlerFunc(userHandler.GetProfile())))
	mux.Handle("POST /api/user/refresh", middleware.AuthMiddleware(tokenService, http.HandlerFunc(authHandler.RefreshTokenHandler())))
	mux.Handle("GET /api/user/order", middleware.AuthMiddleware(tokenService, http.HandlerFunc(userHandler.GetOrdersByUserId())))
	mux.Handle("POST /api/user/logout", middleware.AuthMiddleware(tokenService, http.HandlerFunc(userHandler.LogoutHandler())))
	// CORS middleware
	handler := util.CorsMiddleware(mux)

	//Start server
	log.Println("Starting server on", cfg.Port)
	if err := http.ListenAndServe(cfg.Port, handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
