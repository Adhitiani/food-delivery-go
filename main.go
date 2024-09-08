package main

import (
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
	db.SetMaxOpenConns(10) // Set the maximum number of open connections
	db.SetMaxIdleConns(5)  // Set the maximum number of idle connections
	defer db.Close()

	supplierRepo := postgres.NewSupplierDbRepository(db)
	supplierService := service.NewSupplierService(supplierRepo)
	menuRepo := postgres.NewMenuItemRepository(db)
	menuService := service.NewMenuItemService(menuRepo, supplierRepo)
	typeRepo := postgres.NewTypeRepository(db)
	typeService := service.NewTypeRepository(typeRepo)

	//menuService.PriceUpdater()

	//supplierService.SupplierUpdater()

	//create a new servemux
	mux := http.NewServeMux()
	mux.HandleFunc("GET /suppliers", handler.GetAllSuppliersHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}", handler.GetSupplierByIdHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}/menus", handler.GetMenuItemBySupplierIdHandler(menuService, supplierService))
	mux.HandleFunc("GET /types", handler.GetAllTypeHandler(typeService))

	// Wrap the mux with CORS ddleware
	handler := util.CorsMiddleware(mux)

	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
