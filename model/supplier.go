package model

// create struct type to store the data
type WorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

type Supplier struct {
	Id           int          `json:"id" db:"id"`                   // Internal DB ID (not exposed)
	ExternalId   int          `json:"external_id" db:"external_id"` // External ID from API (mapped to "id" in API response)
	Name         string       `json:"name"`
	Type         string       `json:"type"`
	Image        string       `json:"image"`
	WorkingHours WorkingHours `json:"workingHours"`
}

type SuppliersResponse struct {
	Suppliers []Supplier
}

type SupplierIds struct {
	Id         int `json:"id"`
	ExternalId int `json:"external_id"`
}
