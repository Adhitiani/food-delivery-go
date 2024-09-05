package model

// create struct type to store the data
type WorkingHours struct {
	Opening string `json:"opening"`
	Closing string `json:"closing"`
}

type Supplier struct {
	Id           int          `json:"id"`
	Name         string       `jason:"name"`
	Type         string       `json:"type"`
	Image        string       `json:"image"`
	WorkingHours WorkingHours `json:"workinghours"`
}

type SuppliersResponse struct {
	Suppliers []Supplier
}
