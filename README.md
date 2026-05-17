# Vehicle Sales Data Analysis using SQL

![MySQL](https://img.shields.io/badge/MySQL-Database-blue?logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Data%20Analysis-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## Project Overview

This project analyzes vehicle sales data using SQL to uncover insights related
to customer behavior, vehicle preferences, revenue trends, discount patterns,
and shipping efficiency. The analysis demonstrates practical SQL skills applied
to real-world business questions across three relational tables.

---

## Sample Query Output

<img width="584" height="373" alt="image" src="https://github.com/user-attachments/assets/ce5a326a-92dd-4bad-886f-e6ce0f16a8c3" />

---

## Database Schema

Three relational tables are used in this analysis:

| Table        | Key Columns                                                        |
|--------------|--------------------------------------------------------------------|
| customer_t   | customer_id, state, credit_card_type, customer_feedback            |
| order_t      | order_id, customer_id, product_id, quantity, vehicle_price,        |
|              | discount, order_date, ship_date, quarter_number                    |
| product_t    | product_id, vehicle_maker, vehicle_model, vehicle_color,           |
|              | vehicle_model_year, vehicle_price                                  |

---

## Business Questions Solved

| No. | Business Question                              | SQL Concepts Used              |
|-----|------------------------------------------------|-------------------------------|
| 1   | Customer distribution by state                 | GROUP BY, COUNT, ORDER BY     |
| 2   | Average feedback rating by quarter             | CTE, CASE, AVG                |
| 3   | Customer feedback trend over time              | CTE, CASE, percentage calc    |
| 4   | Top 5 most preferred vehicle makers            | JOIN, GROUP BY, LIMIT         |
| 5   | State-wise most preferred vehicle maker        | JOIN, RANK(), window function |
| 6   | Order volume trend by quarter                  | GROUP BY, COUNT               |
| 7   | Quarter-over-quarter revenue change            | CTE, LAG(), window function   |
| 8   | Revenue and order trend by quarter             | GROUP BY, SUM, COUNT          |
| 9   | Average discount by credit card type           | JOIN, AVG, GROUP BY           |
| 10  | Average shipping time by quarter               | DATEDIFF, AVG, GROUP BY       |

---

## SQL Concepts Demonstrated

- SQL Joins (INNER JOIN across multiple tables)
- Aggregate Functions (SUM, COUNT, AVG)
- CASE Statements for data transformation
- GROUP BY and ORDER BY
- Window Functions (RANK, LAG)
- Common Table Expressions (CTE)
- Date Functions (DATEDIFF)
- Quarter-over-Quarter percentage change calculation

---

## Key Insights

- Certain states show significantly higher customer concentration
- A small group of vehicle manufacturers dominates total purchases
- Revenue fluctuates across quarters, indicating seasonal demand patterns
- Discount offerings vary across different credit card types
- Shipping time analysis reveals order fulfillment efficiency trends
- Customer satisfaction scores show measurable changes quarter over quarter

---

## Tools Used

| Tool              | Purpose                        |
|-------------------|--------------------------------|
| MySQL             | Database and query execution   |
| MySQL Workbench   | SQL development environment    |

---

## How to Run

1. Clone this repository:
   git clone https://github.com/PushpalathaSidd/vehicle-sales-sql-analysis.git

2. Open MySQL Workbench and connect to your local server

3. Create the database:
   CREATE DATABASE vehicle_analysis;
   USE vehicle_analysis;

4. Import your dataset tables (customer_t, order_t, product_t)

5. Open and run vehicle_sales_sql_analysis.sql

---

## Files Included

vehicle-sales-sql-analysis/
vehicle_sales_sql_analysis.sql   — All SQL queries with comments
README.md                        — Project documentation

---

## Author

Pushpalatha Sidd

- LinkedIn: https://www.linkedin.com/in/pushpalatha-s-1a6187285/
- GitHub: https://github.com/PushpalathaSidd
- Tableau: https://public.tableau.com/app/profile/pushpalatha.sidd/vizzes

---

This project is part of my data analytics portfolio. Feedback and suggestions are welcome.
