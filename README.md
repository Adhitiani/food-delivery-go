🍔 Food Delivery Go - Backend

Food Delivery Go is the backend service for a food delivery application that allows authorized users to order food from various suppliers, such as restaurants, supermarkets, and cafes. The backend is built using Golang and PostgreSQL, following clean architecture principles and best practices.

🚀 Features
User Authentication: Login, registration, and JWT-based authentication.
Supplier Management: Retrieve a list of all food suppliers.
Category & Product Listing: Fetch categories and products either by supplier or by category.
Cart Functionality: Add/remove products from the cart.
Order Processing: Confirm and manage food orders, including delivery details.
Order History: View past orders and specific order details.
Search & Filters (Planned): Search products and filter results by supplier type, working hours, and category.
Password Reset (Planned).

🛠️ Tech Stack
Backend: Golang
Database: PostgreSQL
API Gateway: NGINX
Authentication: JWT
Code Quality: Go linters for maintaining clean and efficient code

📌 Architecture
The backend follows a structured approach with the following layers:
Handlers: Handle HTTP requests and responses.
Services: Contain business logic.
Repositories: Interact with the PostgreSQL database.
Middleware: Authentication and request validation.

🔧 Setup & Installation
Clone the repository:
```
git clone https://github.com/your-username/food-delivery-go.git
cd food-delivery-go
```
Configure database connection in .env.
Run the backend server:
```
go run main.go
```

📜 License
This project is licensed under MIT License.

