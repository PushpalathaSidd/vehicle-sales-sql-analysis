USE vehicle_analysis;
/* =====================================================
   VEHICLE SALES SQL ANALYSIS PROJECT
   =====================================================

   Project Overview:
   This project analyzes vehicle sales data to understand
   customer behavior, sales trends, and business performance.

   Key Analysis Areas:
   1. Customer distribution across states
   2. Customer feedback and satisfaction trends
   3. Popular vehicle manufacturers
   4. Order and revenue trends by quarter
   5. Discount analysis by payment method
   6. Shipping time efficiency

   Tools Used:
   - MySQL
   - SQL Aggregations
   - Window Functions (RANK, LAG)
   - CTE (Common Table Expressions)

   Objective:
   Generate business insights from vehicle sales data
   using SQL queries and analytical techniques.
===================================================== */

/* 1. Database Setup */

create database vehical_analysis;

/* 2. Data Validation */

select * from customer_t
limit 10;

/* ============================================
	3. CUSTOMER ANALYSIS
=============================================== */
/* Q1: Customer Distribution by State
   Objective: Analyze how customers are distributed across different states and identify which states 
   have the highest number of customers.
*/

select 
	state,
	count( customer_id) as num_of_customers
from customer_t
group by state
order by num_of_customers desc;

/* ==============================================
 4. CUSTOMER FEEDBACK ANALYSIS
 =============================================*/
 
 /* Q2: Average Customer Feedback Rating by Quarter
   Objective: Convert customer feedback categories into numerical scores and calculate the average feedback
   rating for each quarter to analyze customer satisfaction trends.*/
 
 with feed_bucket as
 (
 select 
	case
		when customer_feedback = "Very Good" then 5
        when customer_feedback = "Good" then 4
        when customer_feedback = "Okay" then 3
        when customer_feedback = "Bad" then 2
        when customer_feedback = "Very Bad" then 1
	end as Feedback_count, 
    Quarter_number
from order_t
)
select
		quarter_number,
        avg(feedback_count) as avg_feedback
        from feed_bucket
        group by quarter_number
        order by 1;
        
/*  ===============================================
	5. CUSTOMER FEEDBACK TREND ANALYSIS
    =============================================== */

/* Q3. Q3: Customer Feedback Trend Over Time
   Objective: Analyze the percentage distribution of each feedback category across quarters to understand whether
   customer satisfaction is improving or declining over time. */
    
with cust_feedback as
(
select
	quarter_number,
		sum(case when customer_feedback = 'Very Good' then 1 else 0 end) as very_good,
		sum(case when customer_feedback = 'Good' then 1 else 0 end) as good,
		sum(case when customer_feedback = 'okay' then 1 else 0 end) as okay,
		sum(case when customer_feedback = 'Bad' then 1 else 0 end) as bad,
		sum(case when customer_feedback = 'Very Bad' then 1 else 0 end) as very_bad,
		count(customer_feedback) as total_feedback
		
	from order_t
    group by 1
)
select 
	quarter_number,
    (very_good / total_feedback) * 100 as perc_very_good,
   (good / total_feedback) * 100 as perc_good,
   (okay / total_feedback) * 100 as perc_okay,
   (bad / total_feedback) * 100 as perc_bad,
   (very_bad / total_feedback) * 100 as perc_very_bad
   
from cust_feedback
order by 1;

/* ===========================================================
	6. VEHICLE MAKER POPULARITY ANALYSIS
=============================================================*/

/* Q4. Top 5 Most Preferred Vehicle Makers
   Objective: Identify the top 5 vehicle manufacturers based on the number of customers who purchased vehicles from each maker.
   This helps determine the most popular vehicle brands among customers*/
    
select
	vehicle_maker,
    count(cust.customer_id) as number_of_customer
from product_t pro
		inner join order_t ord
			on pro.product_id = ord.product_id
        inner join customer_t cust
			on ord.customer_id = cust.customer_id
            group by 1
order by 2 desc
limit 5; 

/* ======================================================
   7. STATE-WISE MOST PREFERRED VEHICLE MAKER
   ====================================================== */

/* Q5. State-wise Most Preferred Vehicle Maker
   Objective: Identify the most preferred vehicle manufacturerin each state based on the number of customers who purchased vehicles.
    Vehicle makers are ranked within each state using the RANK() window function to determine the top performer. */

SELECT state, vehicle_maker
FROM (
        SELECT
            state,
            vehicle_maker,
            COUNT(cust.customer_id) AS no_of_cust,
            RANK() OVER (PARTITION BY state ORDER BY COUNT(customer_id) DESC) AS rnk
FROM product_t pro
	INNER JOIN order_t ord
		ON pro.product_id = ord.product_id
	INNER JOIN customer_t cust
		ON ord.customer_id = cust.customer_id
	GROUP BY 1,2) tbl
WHERE rnk = 1; 

  /* ======================================================
   8. ORDER TREND ANALYSIS
   ====================================================== */

/* Q6: Order Volume Trend by Quarter
   Objective: Analyze the trend of customer orders across different quarters by calculating the total number of 
   orders placed in each quarter */

SELECT
    quarter_number,
    COUNT(order_id) AS total_orders
FROM order_t
GROUP BY 1
ORDER BY 1 ASC;

/* ======================================================
   9. QUARTER OVER QUARTER REVENUE CHANGE
   ====================================================== */

/* Q7. Quarter-over-Quarter Revenue Change Analysis
   Objective: Calculate the revenue generated in each quarter and analyze the percentage change in revenue compared to
   the previous quarter using the LAG() window function. */

WITH QoQ AS
(
    SELECT
        quarter_number,
        SUM(quantity * (vehicle_price - ((discount/100) * vehicle_price))) AS revenue
    FROM order_t
    GROUP BY 1
)
SELECT
    quarter_number,
    revenue,
    LAG(revenue) OVER(ORDER BY quarter_number) AS previous_revenue,
    (revenue - LAG(revenue) OVER(ORDER BY quarter_number))
        / LAG(revenue) OVER(ORDER BY quarter_number) AS qoq_perc_change
FROM QoQ;

/* ======================================================
   10. REVENUE AND ORDER TREND BY QUARTER
   ====================================================== */

/* Q8. Revenue and Order Trend by Quarter
   Objective: Analyze the overall business performance by calculating the total revenue generated and the total
   number of orders placed in each quarter. */

SELECT
    quarter_number,
    SUM(quantity * (vehicle_price - ((discount/100) * vehicle_price))) AS revenue,
    COUNT(order_id) AS total_orders
FROM order_t
GROUP BY quarter_number
ORDER BY 1;

/* ======================================================
   11. AVERAGE DISCOUNT BY CREDIT CARD TYPE
   ====================================================== */

/* Q9. Average Discount by Credit Card Type
   Objective: Evaluate how discount offerings vary across different credit card types by calculating the average
   discount provided for each card category. */

SELECT
    credit_card_type,
    AVG(discount) AS average_discount
FROM order_t ord
INNER JOIN customer_t cust
    ON ord.customer_id = cust.customer_id
GROUP BY credit_card_type
ORDER BY 2 DESC;

/* ======================================================
   12. AVERAGE SHIPPING TIME BY QUARTER
   ====================================================== */

/* Q10.  Average Shipping Time by Quarter
   Objective: Analyze the efficiency of the order fulfillment process by calculating the average time taken to ship orders
   in each quarter using the DATEDIFF() function.*/

SELECT
    quarter_number,
    AVG(DATEDIFF(ship_date, order_date)) AS average_shipping_time
FROM order_t
GROUP BY 1
ORDER BY 1;



/* =====================================================
   PROJECT INSIGHTS
   =====================================================

   Key Findings from the Analysis:

   1. Customer Distribution
      Certain states have a higher concentration of customers,
      indicating strong regional demand for vehicles.

   2. Customer Satisfaction
      Feedback ratings show the overall satisfaction trend
      across quarters and help identify periods with lower
      customer satisfaction.

   3. Popular Vehicle Makers
      A small number of vehicle manufacturers dominate the
      market based on the number of purchases.

   4. State-wise Preferences
      Different states prefer different vehicle makers,
      showing regional brand preferences.

   5. Order Trends
      The number of orders varies across quarters,
      helping identify seasonal demand patterns.

   6. Revenue Growth
      Quarter-over-quarter revenue change helps track
      business growth and identify high-performing periods.

   7. Discounts
      Average discounts vary by credit card type,
      indicating different promotional strategies.

   8. Shipping Efficiency
      Average shipping time analysis helps evaluate
      order fulfillment efficiency.

===================================================== */

-- ---------------------------------------------------------------------------------------------------------------------------------------
--                                                        THE END
-- ---------------------------------------------------------------------------------------------------------------------------------------









 
















