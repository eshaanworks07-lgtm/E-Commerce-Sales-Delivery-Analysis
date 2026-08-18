-- E-Commerce Sales & Delivery Analysis
-- Dataset: Olist (Kaggle) - using the orders + order_items tables
-- Goals: 
-- 1. check if revenue is trending up or down month to month
-- 2. whether late deliveries are actually a big enough problem to flag

-- 1. Viewing the Data
select * FROM olist_orders_dataset;
select * FROM olist_order_items_dataset;

-- checking the data first
Select count(*) FROM olist_orders_dataset;
Select count(*) FROM olist_order_items_dataset;

-- what are the Delivery statuses that exist?
Select order_status, count(*) as Total_Orders FROM olist_orders_dataset 
Group by order_status  Order by Total_Orders DESC;
-- -- We only need Delivered Orders to Calculate the Revenue Pattern
-- -- Delivered Order: 54429

-- -- Do any delivered orders have a missing delivery date?
select count(*) as Null_Orders FROM olist_orders_dataset 
where order_status = 'Delivered' and order_id is NULL;
-- Found: No Null Deliveries

-- Finding total revenue, total orders, avg item price
Select Count(Distinct(o.order_id)) as Total_Orders, round(Sum(oi.price),2) AS Total_Revenue,  round(avg(oi.price),2) AS Avg_Item_Price FROM olist_orders_dataset AS o
INNER JOIN olist_order_items_dataset AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- found: Total Orders: 54429 , 
-- Total Revenue: 7487011.94, 
-- Average Item Price: 120.56

-- now Finding the Revenue by Month - going up or down?
Select   DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') as Order_Month,  COUNT(DISTINCT o.order_id) AS orders, ROUND(SUM(oi.Price), 2) as Total_Revenue FROM olist_orders_dataset as o
INNER JOIN olist_order_items_dataset as oi
ON o.order_id = oi.order_id
where order_status = 'Delivered'
GROUP BY Order_Month
ORDER BY Order_Month;


-- how many days delivery actually takes, per order --
 SELECT order_id, DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) as Delivery_Days,
 Case WHEN
			order_delivered_customer_date > order_estimated_delivery_date
            THEN 'Late' Else 'On Time' END AS Delivery_Status
FROM olist_orders_dataset
WHERE order_status = 'Delivered';

-- what I found:  Delivery Days vary significantly across the orders, some may take 27 days and be on timea and some may take 24 days and be late, according to the Estimate Date.

-- % of orders delivered late, overall
select ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date then 1 else 0 end) / count(*), 2) AS Late_Delivery_Percent FROM olist_orders_dataset
Where ORder_status = 'Delivered';

-- found: Only 8% of all the Devileries are Late

-- Finding Late Percentage by Month, to see if it's getting better or worse with time
Select DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS Order_month,   count(*) as Orders,
ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date then 1 else 0 end) / count(*), 2) as Late_percent
FROM olist_orders_dataset
Where Order_Status = 'Delivered'
GROUP BY  Order_month
ORDER by  Order_month;

-- what I found: 
-- late Percentage stays in the 3-7% range most months, but peaks to 14% in Nov 2017
-- it makes sense as the it fits the order-volume increase from the revenue analysis,given more orders = more pressure on Delivery logistics 
-- the real spike is on Feb-Mar 2018 at 15-21% late, way above every other month
-- the real reason behind it is unknown, we can research more into it rather than guessing the cause

-- Export to Excel- 1 order 1 row, Total Odervalue, Delivery Days, Delivery Status.
Select
o.order_id,
date_format(o.order_purchase_timestamp, '%Y-%m') AS Order_Month,
	ROUND(SUM(oi.price + oi.freight_value), 2) AS Order_Value,
    DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS Delivery_Days,
  Case WHEN
			order_delivered_customer_date > order_estimated_delivery_date
            THEN 'Late' Else 'On Time' END AS Delivery_Status
FROM olist_orders_dataset as O
inner join olist_order_items_dataset as oi
ON o.order_id = oi.order_id
WHERE order_status = 'Delivered'
GROUP BY o.order_id, order_month, o.order_delivered_customer_date,
         o.order_purchase_timestamp, o.order_estimated_delivery_date;


-- imported the Customer Review Table just to kind of look into the late delivery problem and correlation further.
select date_format(review_creation_Date, '%Y-%m'), review_score from olist_order_reviews_dataset order by review_creation_date;

-- does a late delivery actually hurt the review score?
SELECT
    CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
         THEN 'Late' ELSE 'On Time' END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS num_reviews
FROM olist_orders_dataset o
INNER JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY delivery_status;



-- ------------------------------------------------------------
-- what I found overall:
-- 1. The Revenue can be seen strongly Increasing from Sept 2016 to Nov 2017, it is also where it peaked to '565140.95', 
--    then we see a  fluctuation in the 459K-551K range through 2018 instead of going up.
--  Of all the Orders there's only roughly 8% of the Orders that were late.
-- - not a steady trend either way late % stays low at 3-7% in most months, but spikes hard twice: Nov 2017 (14.43%, alongside the
--   order-volume surge) and Feb-Mar 2018 (15.78% then 20.80% - the
--   worst two months by far, no clear cause found yet)
--   The Average Review Scores do show a drastic difference in times when the reveiws where Late and On Time
-- Late - 2.67     On Time- 4.17
-- Also there's a Dip in Review Scores during the November 2017 and March 2018  Period., which shows Correlation between Late Deliveries and Poor Customer Feedback.
