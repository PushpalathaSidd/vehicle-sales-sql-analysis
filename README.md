# Vehicle Sales Data Analysis using SQL

## Project Overview
This project analyzes vehicle sales data to uncover insights related to customer behavior, product popularity, sales performance, and operational efficiency.  
Using SQL, the analysis focuses on identifying patterns in customer distribution, vehicle preferences, revenue trends, feedback ratings, discounts, and shipping performance.

The objective of this project is to demonstrate practical SQL skills used in real-world data analysis tasks.

---

## Dataset Description

The analysis uses three main tables:

Customer Table (customer_t)
- customer_id
- state
- credit_card_type
- customer_feedback

Order Table (order_t)
- order_id
- customer_id
- product_id
- quantity
- vehicle_price
- discount
- order_date
- ship_date
- quarter_number

Product Table (product_t)
- product_id
- vehicle_maker
- vehicle_model
- vehicle_color
- vehicle_model_year
- vehicle_price

---

## Business Questions Solved

1. Customer Distribution by State  
Identify which states have the highest number of customers.

2. Average Customer Feedback by Quarter  
Convert customer feedback categories into numerical scores and calculate the average satisfaction rating.

3. Customer Feedback Trend Analysis  
Analyze whether customer satisfaction changes across quarters.

4. Top 5 Vehicle Makers Preferred by Customers  
Determine which vehicle manufacturers are most popular based on purchases.

5. State-wise Most Preferred Vehicle Maker  
Identify the most popular vehicle brand in each state using ranking functions.

6. Order Trend by Quarter  
Analyze how the number of orders changes over different quarters.

7. Quarter-over-Quarter Revenue Change  
Calculate revenue for each quarter and measure percentage change using window functions.

8. Revenue and Order Trend by Quarter  
Analyze both revenue and order count trends over time.

9. Average Discount by Credit Card Type  
Determine which credit card types receive higher discounts.

10. Average Shipping Time by Quarter  
Measure order fulfillment efficiency using shipping duration.

---

## SQL Concepts Used

This project demonstrates the use of several important SQL concepts:

- SQL Joins
- Aggregate Functions (SUM, COUNT, AVG)
- CASE Statements
- GROUP BY and ORDER BY
- Window Functions (RANK, LAG)
- Common Table Expressions (CTE)
- Date Functions (DATEDIFF)
- Data Transformation Techniques

---

## Key Insights

* Certain states show higher customer concentration, indicating stronger regional demand.  
* A small group of vehicle manufacturers dominates total purchases.  
* Revenue trends fluctuate across quarters, highlighting seasonal demand patterns.  
* Discount patterns vary across different credit card types.  
* Shipping time analysis provides insight into order fulfillment efficiency.
---

## Tools Used

- MySQL Workbench  
- SQL

---

## Author

Pushpalatha  
Aspiring Data Analyst
