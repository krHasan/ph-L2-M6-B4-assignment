-- creating books table
CREATE TABLE books
(
    id             SERIAL PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    author         VARCHAR(50)  NOT NULL,
    price          NUMERIC(4, 2) CHECK ( price >= 0.00 ),
    stock          INT CHECK ( stock >= 0 ) DEFAULT 0,
    published_year INT
);
-- inserting sample data to books table
INSERT INTO books (id, title, author, price, stock, published_year)
VALUES (1, 'The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
       (2, 'Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
       (3, 'You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
       (4, 'Refactoring', 'Martin Fowler', 50.00, 3, 1999),
       (5, 'Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

-- creating customers query
CREATE TABLE customers
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    email       VARCHAR(50) NOT NULL UNIQUE,
    joined_date DATE DEFAULT NOW()
);
-- inserting sample data to customers table
INSERT INTO customers (id, name, email, joined_date)
VALUES (1, 'Alice', 'alice@email.com', '2023-01-10'),
       (2, 'Bob', 'bob@email.com', '2022-05-15'),
       (3, 'Charlie', 'charlie@email.com', '2023-06-20');

-- creating orders table
CREATE TABLE orders
(
    id          SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers (id),
    book_id     INT NOT NULL REFERENCES books (id),
    quantity    INT CHECK (quantity > 0),
    order_date  TIMESTAMP DEFAULT NOW()
);
-- inserting sample data to orders table
INSERT INTO orders (id, customer_id, book_id, quantity, order_date)
VALUES (1, 1, 2, 1, '2024-03-10'),
       (2, 2, 1, 1, '2024-02-20'),
       (3, 1, 3, 2, '2024-03-05');





-- to check all inserted data into tables
SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- 1. Find books that are out of stock.
-- this query will return books title list that has no stock
SELECT title
FROM books
WHERE stock = 0;

-- 2. Retrieve the most expensive book in the store.
-- this query will return only one book data which is most pricey
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;

-- 3. Find the total number of orders placed by each customer.
-- this query will return the customer's name and their corresponding total number of orders
SELECT c.name AS "name"
     , COUNT(o.id) AS "total_orders"
FROM customers c
         LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 0;

-- 4. Calculate the total revenue generated from book sales.
-- this query will return the sum of the total revenue earn from orders
SELECT SUM(b.price * o.quantity) AS "total_revenue"
FROM orders o
         INNER JOIN books b ON b.id = o.book_id;

-- 5. List all customers who have placed more than one order.
-- this query will return the customer's name and corresponding orders count who han more then one order
SELECT c.name AS "name"
     , COUNT(o.id) AS "orders_count"
FROM customers c
         INNER JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 1;

-- 6. Find the average price of books in the store.
-- this will return the average price of all books
SELECT AVG(price) AS "avg_book_price"
FROM books;

-- 7. Increase the price of all books published before 2000 by 10%.
-- this update query will update the book's price by 10% which published year is before 2000
UPDATE books
SET price = (price * 0.1) + price
WHERE published_year < 2000;
-- SELECT * FROM books;

-- 8. Delete customers who haven't placed any orders.
-- this will delete the customer's data form customers table who haven't placed any orders yet
DELETE
FROM customers
WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);
-- SELECT * FROM customers;



