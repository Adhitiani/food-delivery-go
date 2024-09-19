package model

// create struct type to store the data
type WorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

type Supplier struct {
	Id           int          `json:"id" db:"external_id"`
	Name         string       `json:"name"`
	Type         string       `json:"type"`
	Image        string       `json:"image"`
	WorkingHours WorkingHours `json:"workinghours"`
}

type SuppliersResponse struct {
	Suppliers []Supplier
}

type SupplierIds struct {
	Id         int `json:"id"`
	ExternalId int `json:"external_id"`
}
