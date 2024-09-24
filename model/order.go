package model

type Order struct {
	ID            int         `json:"id"`
	UserID        int         `json:"user_id"`       // User ID for the order
	SupplierID    int         `json:"supplier_id"`   // Supplier ID from the order
	SupplierName  string      `json:"supplier_name"` // Supplier name for display
	TotalPrice    float64     `json:"total_price"`
	Address       string      `json:"address"`
	Phone         string      `json:"phone"`
	PaymentMethod string      `json:"payment_method"`
	CreatedAt     string      `json:"created_at"`
	Items         []OrderItem `json:"items"` // List of order items
}

type OrderItem struct {
	OrderID      int     `json:"order_id"`
	MenuItemID   int     `json:"menu_item_id"` // Ensure this matches the incoming JSON
	MenuItemName string  `json:"name"`
	Quantity     int     `json:"quantity"`
	Price        float64 `json:"price"`
}
