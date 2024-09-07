package main

import (
	"database/sql"
	"log"
	"net/http"
	"project/food-delivery/handler"
	postgres "project/food-delivery/repository/db"
	"project/food-delivery/service"
	"project/food-delivery/util"

	_ "github.com/lib/pq"
)

func main() {
	// Set up PostgreSQL connection
	connStr := "user=food_delivery_user password=password123 dbname=food_delivery sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("error connecting to the database: %v", err)
	}
	defer db.Close()

	supplierRepo := postgres.NewSupplierDbRepository(db)
	supplierService := service.NewSupplierService(supplierRepo)
	MenuRepo := postgres.NewMenuItemRepository(db)
	MenuService := service.NewMenuItemService(MenuRepo)

	MenuService.PriceUpdater()

	//supplierService.SupplierUpdater()

	//create a new servemux
	mux := http.NewServeMux()
	mux.HandleFunc("GET /suppliers", handler.GetAllSuppliersHandler(supplierService))
	mux.HandleFunc("GET /suppliers/{id}", handler.GetSupplierByIdHandler(supplierService))
	mux.HandleFunc("GET /menus/{supplierId}", handler.GetMenuItemBySupplierIdHandler(MenuService, supplierService))

	// Wrap the mux with CORS ddleware
	handler := util.CorsMiddleware(mux)

	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
