create database Book_sales;

drop table if exists books;
create table books(
	Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

drop table if exists customer;
create table Customer(
       Customer_ID SERIAL PRIMARY KEY,
       Name  VARCHAR(100),
       Email  VARCHAR(100),
       Phone  VARCHAR(15),
       City VARCHAR(50),
       Country VARCHAR(150)
);

drop table if exists orders;
create table orders(
		Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
select*from books;
select*from customer;
select *from orders;

-- Basic lavel:
-- 1) Retrieve all books in the "Fiction" genre:
-- 2) Find books published after the year 1950:
-- 3) List all customers from the Canada:
-- 4) Show orders placed in November 2023:
-- 5) Retrieve the total stock of books available:
-- 6) Find the details of the most expensive book:
-- 7) Show all customers who ordered more than 1 quantity of a book:
-- 8) Retrieve all orders where the total amount exceeds $20:
-- 9) List all genres available in the Books table:
-- 10) Find the book with the lowest stock:
-- 11) Calculate the total revenue generated from all orders:

-- 1) Retrieve all books in the "Fiction" genre:
select*from books
where genre="Fiction";

-- 2) Find books published after the year 1950:
select count(*)from books 
where Published_Year>"1950";

select*from books
where Published_Year>1950;

-- 3) List all customers from the Canada:
select*from customer
where Country="Canada";

-- 4) Show orders placed in November 2023:
select*from orders
where order_Date between '2023-11-1' and '2023-11-31';

-- 5) Retrieve the total stock of books available:
select sum(Stock) AS Total_stock
from books;

-- 6) Find the details of the most expensive book:
select*from books
order by Price DESC
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select*from orders
where Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select*from orders
where Total_Amount>20;

-- 9) List all genres available in the Books table:
select distinct Genre
from books;

-- 10) Find the book with the lowest stock:
select*from books
order by Stock
limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as total_revenue
from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
-- 2) Find the average price of books in the "Fantasy" genre:
-- 3) List customers who have placed at least 2 orders:
-- 4) Find the most frequently ordered book:
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
-- 6) Retrieve the total quantity of books sold by each author:
-- 7) List the cities where customers who spent over $30 are located:
-- 8) Find the customer who spent the most on orders:
-- 9) Calculate the stock remaining after fulfilling all orders:

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.genre, SUM(o.quantity) AS total_books_by_genre
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(Price) AS AVG_price
from books
where genre="Fantasy";

-- 3) List customers who have placed at least 2 orders:
SELECT o.Customer_id, c.Name, COUNT(o.Order_ID) AS ORDER_COUNT
FROM orders o
JOIN customer c 
    ON o.Customer_id = c.Customer_id
GROUP BY o.Customer_id, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Total_count
FROM orders o
JOIN books b 
    ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Total_count DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.Author,b.Title, SUM(o.Quantity) AS Total_Quantity
FROM books b
JOIN orders o ON b.Book_id = o.Book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City
FROM customer c
JOIN orders o ON c.Customer_id = o.Customer_id
JOIN books b ON o.Book_id = b.Book_id
GROUP BY c.Customer_id, c.City
HAVING SUM(o.Quantity * b.Price) > 30;

-- 8) Find the customer who spent the most on orders:
select c.Customer_ID,c.Name,SUM(Total_Amount) as Total_Amount
from customer c
join orders o on c.Customer_ID=o.Customer_ID
group by c.Customer_ID,c.Name
order by Total_Amount DESC;


-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_ID, b.Title,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;