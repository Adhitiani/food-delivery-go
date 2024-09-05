package service

//The service package usually contains the business logic and manages interactions between the repository layer and external dependencies (like APIs or databases).

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"project/food-delivery/model"
	"project/food-delivery/repository"
	"project/food-delivery/util"
	"time"
)

type SupplierService struct {
	repo repository.SupplierRepository
}

func NewSupplierService(repo repository.SupplierRepository) *SupplierService {
	return &SupplierService{repo: repo}
}

func (s *SupplierService) FetchSuppliers(url string) ([]model.Supplier, error) {
	//bypass the tls security
	client := util.CreateInsecureClient()

	resp, err := client.Get(url)
	if err != nil {
		return nil, fmt.Errorf("error fetching data: %v", err)
	}

	//close the connection after all the surroundg function finish
	defer resp.Body.Close()

	// need to read the body response in order to use unmarshal to convert Json to struct
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading body: %v", err)
	}

	// create  a variable supplierresponse type to store the result of the converted Json

	var result model.SuppliersResponse

	// convert the bytes to SuppliersResponse struct

	err = json.Unmarshal(body, &result)
	if err != nil {
		return nil, fmt.Errorf("error unmarshaling data: %v", err)
	}

	// return the Suppliers field from the result struct

	return result.Suppliers, nil

}

func (s *SupplierService) FetchAndInsertSuppliers() error {
	limit := 20
	page := 1

	var allSuppliers []model.Supplier

	// since the data can't be fetch all in one time use loop
	for {
		//create dynamic url
		url := fmt.Sprintf("https://foodapi.golang.nixdev.co/suppliers?limit=%d&page=%d", limit, page)

		suppliers, err := s.FetchSuppliers(url)
		if err != nil {
			log.Fatalf("error fetching supplier: %v", err)
		}

		// if there is no more suppliers result exit the loop
		if len(suppliers) == 0 {
			break
		}

		//append the suppliers from the current iteration to allSuppliers
		allSuppliers = append(allSuppliers, suppliers...)

		//increment the page for next iteration
		page++
	}

	log.Println("Total Suppliers Fetched:", len(allSuppliers))

	// Insert all fetched suppliers into the database
	err := s.repo.InsertSuppliers(allSuppliers)
	if err != nil {
		log.Fatalf("error inserting suppliers to database: %v", err)
	}

	log.Println("Suppliers inserted into the database successfully!")

	return nil

}

func (s *SupplierService) SupplierUpdater() {
	go func() {
		for {
			// Call the FetchAndInsertSUpplier
			s.FetchAndInsertSuppliers()

			//Sleep for 10 minutes before running the next update
			time.Sleep(10 * time.Minute)
		}

	}()
}

func (s *SupplierService) GetAllSuppliers() ([]*model.Supplier, error) {
	return s.repo.GetAllSuppliers()
}

func (s *SupplierService) GetSupplierById(id int) (*model.Supplier, error) {
	return s.repo.GetSupplierById(id)
}
