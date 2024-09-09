package model

type MenuResponse struct {
	Menu []MenuItem `json:"menu"`
}

type MenuItem struct {
	ID          int      `json:"id"`
	Name        string   `json:"name"`
	Price       float64  `json:"price"`
	Image       string   `json:"image"`
	Type        string   `json:"type"`
	Ingredients []string `json:"ingredients"`
	SupplierId  int      `json:"supplier_id"`
}
