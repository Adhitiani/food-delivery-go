package main

import (
	"context"
	"database/sql"
	"log"
	"net/http"
	_ "net/http/pprof"
	"project/food-delivery/handler"
	postgres "project/food-delivery/repository/db"
	"project/food-delivery/service"
	"project/food-delivery/util"

	_ "github.com/lib/pq"
)

func main() {
	// go func() {
	// 	log.Println(http.ListenAndServe("localhost:6060", nil))
	// }()

	// Set up PostgreSQL connection
	connStr := "user=food_delivery_user password=password123 dbname=food_delivery sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("error connecting to the database: %v", err)
	}

	// Configure connection pooling
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(5)
	defer db.Close()

	supplierRepo := postgres.NewSupplierDbRepository(db)
	supplierService := service.NewSupplierService(supplierRepo)
	menuRepo := postgres.NewMenuItemRepository(db)
	menuService := service.NewMenuItemService(menuRepo, supplierRepo)
	typeRepo := postgres.NewTypeRepository(db)
	typeService := service.NewTypeRepository(typeRepo)

	//update price and suppliers
	menuService.PriceUpdater()
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	go supplierService.SupplierUpdater(ctx)

	mux := http.NewServeMux()
	mux.HandleFunc("GET /suppliers", handler.GetAllSuppliersHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}", handler.GetSupplierByIdHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}/menus", handler.GetMenuItemBySupplierIdHandler(menuService, supplierService))
	mux.HandleFunc("GET /suppliers/{id}/categories", handler.GetSupplierCategoriesHandler(supplierService))
	mux.HandleFunc("GET /categories", handler.GetAllTypeHandler(typeService))
	mux.HandleFunc("GET /categories/suppliers/{category}", handler.GetSupplierByMenuType(supplierService))

	// CORS middleware
	handler := util.CorsMiddleware(mux)

	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
