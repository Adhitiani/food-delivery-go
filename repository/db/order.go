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

func (o *OrderRepository) CreateOrder(order model.Order) error {
	tx, err := o.db.Begin()
	if err != nil {
		return fmt.Errorf("error starting transaction: %v", err)
	}

	var orderID int
	err = tx.QueryRow(
		`INSERT INTO orders (user_id, supplier_id, total_price, address, phone, payment_method, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id`,
		order.UserID, order.SupplierID, order.TotalPrice, order.Address, order.Phone, order.PaymentMethod, time.Now()).Scan(&orderID)
	if err != nil {
		tx.Rollback()
		return fmt.Errorf("error inserting order %v", err)
	}

	for _, item := range order.Items {
		_, err = tx.Exec(
			`INSERT INTO order_items (order_id, menu_item_id, quantity, price)VALUES ($1, $2, $3, $4)`,
			orderID, item.MenuItemID, item.Quantity, item.Price)
		if err != nil {
			tx.Rollback()
			return fmt.Errorf("error to insert order item %v", err)
		}
	}

	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("error to commit transaction %v", err)
	}

	fmt.Printf("Successful creating order with id %d", orderID)
	return nil
}

func (o *OrderRepository) GetOrderDetails(orderID int) (*model.Order, error) {
	var order model.Order
	err := o.db.QueryRow(`
    SELECT o.id, o.total_price, o.address, o.phone, o.payment_method, o.created_at, s.name 
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
		err := rows.Scan(&item.OrderID, &item.MenuItemID, &item.Quantity, &item.Price, &item.MenuItemName)
		if err != nil {
			return nil, fmt.Errorf("error: failed to scan order items %v", err)
		}
		items = append(items, item)
	}

	order.Items = items

	return &order, nil
}
