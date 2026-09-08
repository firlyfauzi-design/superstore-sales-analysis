SELECT *
 FROM `Superstore_sales.Dataset`
 LIMIT 10;


 -- Check the total number of records in the dataset
SELECT COUNT(*) AS total_rows
FROM `Superstore_sales.Dataset`;


-- Check whether Row ID contains duplicate values
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT `Row ID`) AS unique_row_id
FROM `Superstore_sales.Dataset`;


-- Check for missing values in important columns
SELECT
  COUNTIF(`Order ID` IS NULL) AS null_order_id,
  COUNTIF(`Order Date` IS NULL) AS null_order_date,
  COUNTIF(`Customer ID` IS NULL) AS null_customer_id,
  COUNTIF(Category IS NULL) AS null_category,
  COUNTIF(Sales IS NULL) AS null_sales,
  COUNTIF(Quantity IS NULL) AS null_quantity,
  COUNTIF(Discount IS NULL) AS null_discount,
  COUNTIF(Profit IS NULL) AS null_profit
FROM `Superstore_sales.Dataset`;


-- Superstore Sales & Profit Analysis

-- Business Questions:
-- 1. How have sales and profit changed over time?
-- 2. Which categories and sub-categories generate the highest sales and profit?
-- 3. Which regions and states are the most and least profitable?
-- 4. How do discounts affect profitability?
-- 5. Which customer segments contribute the most sales and profit?
-- 6. Which products generate high sales but low or negative profit?

-- Business Question 1
-- How have sales and profit changed over time?

SELECT
  DATE_TRUNC(`Order Date`, MONTH) AS month,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit
FROM `Superstore_sales.Dataset`
GROUP BY month
ORDER BY month;


-- Business Question 2
-- Which categories and sub-categories generate the highest sales and profit?

SELECT
  Category,
  `Sub-Category`,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit
FROM `Superstore_sales.Dataset`
GROUP BY Category, `Sub-Category`
ORDER BY total_sales DESC;



-- Business Question 3
-- Which regions and states are the most and least profitable?

SELECT
  Region,
  State,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit
FROM `Superstore_sales.Dataset`
GROUP BY Region, State
ORDER BY total_profit DESC;



-- Business Question 4
-- How do discounts affect profitability?

SELECT
  Discount,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SAFE_DIVIDE(SUM(Profit), SUM(Sales)) * 100, 2) AS profit_margin_pct
FROM `Superstore_sales.Dataset`
GROUP BY Discount
ORDER BY Discount;



-- Business Question 5
-- Which customer segments contribute the most sales and profit?

SELECT
  Segment,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SAFE_DIVIDE(SUM(Profit), SUM(Sales)) * 100, 2) AS profit_margin_pct
FROM `Superstore_sales.Dataset`
GROUP BY Segment
ORDER BY total_sales DESC;



-- Business Question 6
-- Which products generate high sales but low or negative profit?

SELECT
  `Product Name`,
  ROUND(SUM(Sales), 2) AS total_sales,
  ROUND(SUM(Profit), 2) AS total_profit,
  ROUND(SAFE_DIVIDE(SUM(Profit), SUM(Sales)) * 100, 2) AS profit_margin_pct
FROM `Superstore_sales.Dataset`
GROUP BY `Product Name`
HAVING SUM(Profit) < 0
ORDER BY total_sales DESC
LIMIT 10;



-- =====================================================
-- KEY INSIGHTS
-- =====================================================

-- 1. Sales generally increased from 2014 to 2017, with the
--    highest monthly sales recorded in November 2017.

-- 2. Phones generated the highest sales, while Copiers generated
--    the highest profit. High sales do not always result in high profit.

-- 3. California and New York generated the highest profits,
--    while Texas recorded the largest overall loss despite
--    generating relatively high sales.

-- 4. Discounts of 30% or higher were associated with negative
--    profitability, with losses generally increasing at higher
--    discount levels.

-- 5. The Consumer segment generated the highest total sales and profit,
--    while Home Office achieved the highest profit margin.

-- 6. Several products generated substantial sales but remained
--    unprofitable, indicating that sales performance alone is
--    not sufficient to evaluate product performance.


-- =====================================================
-- BUSINESS RECOMMENDATIONS
-- =====================================================

-- 1. Review discount strategies, especially discounts of 30% or higher,
--    as these transactions are associated with negative profitability.

-- 2. Investigate loss-making states such as Texas, Ohio, Pennsylvania,
--    and Illinois to identify factors contributing to poor profitability.

-- 3. Review the pricing, discount, and cost structure of unprofitable
--    products, particularly products with high sales but negative profit.

-- 4. Maintain focus on high-performing markets such as California
--    and New York while identifying strategies that can be replicated
--    in lower-performing markets.

-- 5. Consider both sales and profit margin when evaluating customer
--    segments, since the Consumer segment contributes the most revenue
--    while Home Office achieves a higher profit margin.


