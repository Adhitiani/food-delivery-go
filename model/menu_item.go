package model

// MenuResponse represents the entire response structure.
type MenuResponse struct {
	Menu []MenuItem `json:"menu"`
}

// MenuItem represents each menu item in the menu.
type MenuItem struct {
	ID          int      `json:"id"`
	Name        string   `json:"name"`
	Price       float64  `json:"price"`
	Image       string   `json:"image"`
	Type        string   `json:"type"`
	Ingredients []string `json:"ingredients"`
	SupplierId  int
}
