# 📚 Book Sales & Customer Analytics (SQL Project)

## 📌 Project Overview

This project focuses on analyzing **book sales, customer behavior, and inventory management** using SQL.
It demonstrates how raw transactional data can be transformed into **meaningful business insights**.

The project covers **real-world business scenarios** like:

* Customer spending analysis
* Best-selling books & authors
* Inventory tracking
* Revenue insights

---

## 🎯 Objectives

* Analyze customer purchasing behavior
* Identify top-performing books and authors
* Track inventory and remaining stock
* Calculate revenue and sales trends
* Solve real-world business problems using SQL

---

## 🗂️ Database Schema

### 📘 1. Books Table

* `Book_ID` (Primary Key)
* `Title`
* `Author`
* `Genre`
* `Price`
* `Stock`

---

### 👤 2. Customer Table

* `Customer_ID` (Primary Key)
* `Name`
* `City`

---

### 🛒 3. Orders Table

* `Order_ID` (Primary Key)
* `Customer_ID` (Foreign Key)
* `Book_ID` (Foreign Key)
* `Quantity`

---

## 🔗 Table Relationships

* Customers place Orders
* Orders contain Books

```
Customer → Orders → Books
```

---

## 🛠️ SQL Concepts Used

* ✅ SELECT, WHERE, ORDER BY
* ✅ GROUP BY & HAVING
* ✅ INNER JOIN & LEFT JOIN
* ✅ Aggregate Functions (SUM, COUNT)
* ✅ Subqueries
* ✅ Data Filtering & Sorting

---

## 📊 Key Business Insights

### 🏆 1. Top Selling Books

Identified the most frequently ordered books using aggregation.

### 💰 2. Customer Spending Analysis

Calculated total spending using:

```
Total Spend = Quantity × Price
```

### 🌍 3. High-Value Customer Locations

Found cities where customers spend more than a defined threshold.

### 📚 4. Author Performance

Analyzed total books sold by each author.

### 📦 5. Inventory Management

Tracked remaining stock after fulfilling orders:

```
Remaining Stock = Stock − Total Sold
```

---

## 🔥 Sample SQL Queries

### 🔹 Top 3 Most Expensive Fantasy Books

```sql
SELECT Book_ID, Title, Price
FROM books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;
```

---

### 🔹 Total Books Sold by Author

```sql
SELECT b.Author, SUM(o.Quantity) AS Total_Quantity
FROM books b
JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Author;
```

---

### 🔹 Customer Who Spent the Most

```sql
SELECT c.Customer_ID, c.Name,
       SUM(o.Quantity * b.Price) AS Total_Amount
FROM customer c
JOIN orders o ON c.Customer_ID = o.Customer_ID
JOIN books b ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Amount DESC
LIMIT 1;
```

---

### 🔹 Remaining Stock Calculation

```sql
SELECT b.Book_ID, b.Title,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;
```

---

## 🚀 Project Highlights

* Solved **real-world business problems using SQL**
* Demonstrated strong understanding of **joins and aggregations**
* Built queries useful for **data analyst roles**
* Clean and structured query writing

---

## 📈 Skills Demonstrated

* SQL Query Writing
* Data Analysis
* Business Problem Solving
* Relational Database Understanding
* Analytical Thinking

---

## 💼 Use Case

This project is highly relevant for:

* Data Analyst roles
* Business Analyst roles
* SQL Developer roles

---

## 📢 Conclusion

This project showcases the ability to work with **relational databases**, perform **complex joins**, and extract **actionable insights** from data — essential skills for any data professional.

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and connect with me!

---
