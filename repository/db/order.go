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
		`INSERT INTO orders (user_id, supplier_id, total_price, address, phone, payment_method, created_at) 
		VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id`,
		order.UserID, order.SupplierID, order.TotalPrice, order.Address, order.Phone, order.PaymentMethod, time.Now(),
	).Scan(&orderID)

	if err != nil {
		tx.Rollback()
		return 0, fmt.Errorf("error inserting order: %v", err)
	}

	fmt.Printf("Successfully created order with id %d\n", orderID)

	fmt.Printf("trying to insert items %v\n", order.Items)

	// Insert each order item
	for _, item := range order.Items {
		var itemID int
		fmt.Printf("Trying to insert item: %+v\n", item)

		// Insert the order item and get the generated order item ID
		err = tx.QueryRow(
			`INSERT INTO order_items (order_id, menu_item_id, quantity, price) 
			VALUES ($1, $2, $3, $4) RETURNING id`,
			orderID, item.MenuItemID, item.Quantity, item.Price,
		).Scan(&itemID)

		if err != nil {
			tx.Rollback()
			return 0, fmt.Errorf("error inserting order item: %v", err)
		}

		fmt.Printf("Successfully inserted order item with id %d\n", itemID)
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
    SELECT o.id, o.total_price, o.address, o.phone, o.payment_method, TO_CHAR(o.created_at,'YYYY-MM-DD HH24:MI:SS') as created_at, s.name, s.id, u.name, u.id 
    FROM orders o
    JOIN suppliers s ON o.supplier_id = s.id
		JOIN users u ON o.user_id = u.id
    WHERE o.id = $1`, orderID).Scan(
		&order.ID, &order.TotalPrice, &order.Address, &order.Phone, &order.PaymentMethod, &order.CreatedAt, &order.SupplierName, &order.SupplierID, &order.UserName, &order.UserID,
	)
	if err != nil {
		return nil, fmt.Errorf("error order not found %v", err)
	}

	rows, err := o.db.Query(`
	SELECT oi.menu_item_id, oi.quantity, oi.price, mi.name 
	FROM order_items oi
	JOIN menu_items mi ON oi.menu_item_id = mi.id
	WHERE oi.order_id = $1`, orderID)
	if err != nil {
		return nil, fmt.Errorf("error fetching order items %v", err)
	}
	defer rows.Close()

	var items []model.OrderItem

	for rows.Next() {
		var item model.OrderItem
		err := rows.Scan(&item.MenuItemID, &item.Quantity, &item.Price, &item.MenuItemName) // Fetching menu_item_id as well
		if err != nil {
			return nil, fmt.Errorf("error: failed to scan order items %v", err)
		}
		item.OrderID = orderID
		items = append(items, item)
	}

	order.Items = items
	return &order, nil
}

func (o *OrderRepository) GetOrdersByUserId(userId int) ([]model.Order, error) {

	query := `
    SELECT o.id, o.total_price, o.address, o.phone, o.payment_method, TO_CHAR(o.created_at,'YYYY-MM-DD HH24:MI:SS') as created_at, s.name, s.id, u.name, u.id 
    FROM orders o
    JOIN suppliers s ON o.supplier_id = s.id
		JOIN users u ON o.user_id = u.id
    WHERE o.user_id = $1 ORDER BY o.id DESC
	`
	stmt, err := o.db.Prepare(query)
	if err != nil {
		return nil, fmt.Errorf("error preparing query %v", err)
	}
	defer stmt.Close()

	rows, err := stmt.Query(userId)
	if err != nil {
		return nil, fmt.Errorf("error order not found %v", err)
	}

	defer rows.Close()

	var orders []model.Order

	for rows.Next() {
		var order model.Order

		err := rows.Scan(
			&order.ID, &order.TotalPrice, &order.Address, &order.Phone, &order.PaymentMethod, &order.CreatedAt, &order.SupplierName, &order.SupplierID, &order.UserName, &order.UserID,
		)
		if err != nil {
			return nil, fmt.Errorf("error: failed to scan orders %v", err)
		}
		orders = append(orders, order)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error during rows iteration: %v", err)
	}

	return orders, nil
}
