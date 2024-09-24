package postgres

import (
	"database/sql"
	"fmt"
	"project/food-delivery/model"
	"time"
)

type OrderRepository struct {
	db *sql.DB
}

func NewOrderRepository(db *sql.DB) *OrderRepository {
	return &OrderRepository{db: db}
}

func (o *OrderRepository) CreateOrder(order model.Order) (int, error) {
	tx, err := o.db.Begin()
	if err != nil {
		return 0, fmt.Errorf("error starting transaction: %v", err)
	}

	var orderID int

	// Insert the main order and get the generated order ID
	err = tx.QueryRow(
		`INSERT INTO orders (user_id, supplier_id, total_price, address, phone, payment_method, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id`,
		order.UserID, order.SupplierID, order.TotalPrice, order.Address, order.Phone, order.PaymentMethod, time.Now()).Scan(&orderID)
	if err != nil {
		tx.Rollback()
		return 0, fmt.Errorf("error inserting order %v", err)
	}

	fmt.Printf("trying to insert items %v\n", order.Items)
	// Insert each order item
	for _, item := range order.Items {
		fmt.Printf("trying to insert item %v\n", item)

		// Create OrderItem from the incoming item
		orderItem := model.OrderItem{
			OrderID:    orderID,         // Set the current order ID
			MenuItemID: item.MenuItemID, // Ensure you're using the correct field
			Quantity:   item.Quantity,
			Price:      item.Price,
		}

		// Use MenuItemName when inserting into the database (if needed)
		_, err = tx.Exec(
			`INSERT INTO order_items (order_id, menu_item_id, quantity, price) VALUES ($1, $2, $3, $4)`,
			orderItem.OrderID, orderItem.MenuItemID, orderItem.Quantity, orderItem.Price)
		if err != nil {
			tx.Rollback()
			return 0, fmt.Errorf("error to insert order item %v", err)
		}
	}

	// Commit the transaction
	err = tx.Commit()
	if err != nil {
		return 0, fmt.Errorf("error to commit transaction %v", err)
	}

	fmt.Printf("Successful creating order with id %d\n", orderID)
	return orderID, nil
}

func (o *OrderRepository) GetOrderDetailsById(orderID int) (*model.Order, error) {
	var order model.Order
	err := o.db.QueryRow(`
    SELECT o.id, o.total_price, o.address, o.phone, o.payment_method, TO_CHAR(o.created_at,'YYYY-MM-DD HH24:MI:SS') as created_at , s.name 
    FROM orders o
    JOIN suppliers s ON o.supplier_id = s.id
    WHERE o.id = $1`, orderID).Scan(
		&order.ID, &order.TotalPrice, &order.Address, &order.Phone, &order.PaymentMethod, &order.CreatedAt, &order.SupplierName,
	)
	if err != nil {
		return nil, fmt.Errorf("error order not found %v", err)
	}

	rows, err := o.db.Query(`
	SELECT oi.quantity, oi.price, mi.name 
	FROM order_items  oi
	JOIN menu_items mi ON oi.menu_item_id = mi.id
	WHERE oi.order_id = $1`, orderID)
	if err != nil {
		return nil, fmt.Errorf("error fetching order items %v", err)
	}
	defer rows.Close()

	var items []model.OrderItem

	for rows.Next() {
		var item model.OrderItem
		err := rows.Scan(&item.Quantity, &item.Price, &item.MenuItemName)
		if err != nil {
			return nil, fmt.Errorf("error: failed to scan order items %v", err)
		}
		items = append(items, item)
	}

	order.Items = items

	return &order, nil
}
