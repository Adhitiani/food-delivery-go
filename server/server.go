package server

import (
	"context"
	"database/sql"
	"log"
	"net/http"
	"project/food-delivery/config"
	"project/food-delivery/handler"
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

	//update price and suppliers
	menuService.PriceUpdater()
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	go supplierService.SupplierUpdater(ctx)

	// Pass both userService and cfg to the UserHandler
	userHandler := handler.NewUserHandler(userService, cfg)

	//Routes
	mux := http.NewServeMux()
	mux.HandleFunc("GET /suppliers", handler.GetAllSuppliersHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}", handler.GetSupplierByIdHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}/menus", handler.GetMenuItemBySupplierIdHandler(menuService, supplierService))
	mux.HandleFunc("GET /suppliers/{id}/categories", handler.GetSupplierCategoriesHandler(supplierService))
	mux.HandleFunc("GET /categories", handler.GetAllTypeHandler(typeService))
	mux.HandleFunc("GET /categories/suppliers/{category}", handler.GetSupplierByMenuType(supplierService))
	mux.HandleFunc("POST /order", handler.CreateOrder(orderService))
	mux.HandleFunc("GET /order/{id}", handler.GetOrderDetailsById(orderService))
	mux.HandleFunc("POST /user/login", userHandler.LoginHandler())
	mux.HandleFunc("POST /user/signup", userHandler.InsertUserHandler())
	mux.HandleFunc("GET /user/profile", userHandler.GetProfile())

	// CORS middleware
	handler := util.CorsMiddleware(mux)

	//Start server
	log.Println("Starting server on", cfg.Port)
	if err := http.ListenAndServe(cfg.Port, handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
