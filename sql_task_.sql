create database sales;
use sales;
-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender CHAR(1),
    country VARCHAR(50)
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers (customer_id, name, age, gender, country) VALUES
(1, 'Alice', 30, 'F', 'USA'),
(2, 'Bob', 45, 'M', 'UK'),
(3, 'Charlie', 25, 'M', 'Canada'),
(4, 'Diana', 35, 'F', 'USA'),
(5, 'Ethan', 50, 'M', 'Germany'),
(6, 'Fiona', 29, 'F', 'Australia'),
(7, 'George', 41, 'M', 'India'),
(8, 'Hannah', 32, 'F', 'UK'),
(9, 'Ian', 28, 'M', 'Canada'),
(10, 'Julia', 38, 'F', 'USA');
INSERT INTO orders (order_id, customer_id, order_amount, order_date) VALUES
(1001, 1, 250.00, '2023-01-10'),
(1002, 2, 300.00, '2023-01-12'),
(1003, 1, 450.00, '2023-02-15'),
(1004, 4, 150.00, '2023-03-01'),
(1005, 5, 500.00, '2023-03-10'),
(1006, 2, 100.00, '2023-04-05'),
(1007, 7, 700.00, '2023-04-15'),
(1008, 8, 250.00, '2023-05-01'),
(1009, 1, 100.00, '2023-05-05'),
(1010, 3, 400.00, '2023-06-10');
select * from customers;
select * from orders;

-- List customers from the USA ordered by age
SELECT * FROM customers
WHERE country = 'USA'
ORDER BY age DESC;

-- Group orders by customer and calculate total amount
SELECT customer_id, SUM(order_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;
-- INNER JOIN: Get customer details with their orders
SELECT c.name, o.order_amount, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- LEFT JOIN: List all customers and their orders (if any)
SELECT c.name, o.order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN (not supported in some databases like MySQL, but logically:)
SELECT o.order_id, c.name, o.order_amount
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id;
-- Customers who spent more than the average order amount
SELECT name FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(order_amount) > (
        SELECT AVG(order_amount) FROM orders
    )
);
-- Average age of customers
SELECT AVG(age) AS average_age FROM customers;

-- Total and average order amount
SELECT SUM(order_amount) AS total_orders, AVG(order_amount) AS avg_order
FROM orders;
-- Create a view of customer spending
CREATE VIEW customer_spending AS
SELECT c.customer_id, c.name, SUM(o.order_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
-- Add indexes for performance

CREATE INDEX idx_order_customer_id ON orders(customer_id);




