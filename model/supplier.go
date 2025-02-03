package model

// the purpose is to represent and manage different versions of the supplier data

// create struct type to store the data
type WorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

// This struct models the supplier data that you fetch directly from the API.
type ApiSupplier struct {
	Id           int          `json:"id"` // External ID from API
	Name         string       `json:"name"`
	Type         string       `json:"type"`
	Image        string       `json:"image"`
	WorkingHours WorkingHours `json:"workingHours"`
}

type Supplier struct {
	Id          int    `json:"id" db:"id"`                   // Internal DB ID (not exposed)
	ExternalId  int    `json:"external_id" db:"external_id"` // External ID from API
	Name        string `json:"name" db:"name"`
	Type        string `json:"type" db:"type"`
	Image       string `json:"image" db:"image"`
	OpeningTime string `json:"opening_time" db:"opening_time"` // Mapped from WorkingHours
	ClosingTime string `json:"closing_time" db:"closing_time"` // Mapped from WorkingHours
}

type SuppliersResponse struct {
	Suppliers []ApiSupplier
}

type SupplierIds struct {
	Id         int `json:"id"`
	ExternalId int `json:"external_id"`
}
