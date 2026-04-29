/*
Project: Chips Sales Analysis
Purpose: SQL queries for business KPI analysis after loading cleaned data into a table named chips_sales.
Author: Sk Sahil Ahamed
*/

-- 1. Total revenue
SELECT 
    ROUND(SUM(TOT_SALES), 2) AS total_revenue
FROM chips_sales;

-- 2. Total transactions
SELECT 
    COUNT(*) AS total_transactions
FROM chips_sales;

-- 3. Total unique customers
SELECT 
    COUNT(DISTINCT LYLTY_CARD_NBR) AS total_customers
FROM chips_sales;

-- 4. Monthly revenue trend
SELECT 
    YEAR,
    MONTH,
    ROUND(SUM(TOT_SALES), 2) AS monthly_revenue
FROM chips_sales
GROUP BY YEAR, MONTH
ORDER BY YEAR, MONTH;

-- 5. Top 10 products by revenue
SELECT 
    PROD_NAME,
    ROUND(SUM(TOT_SALES), 2) AS revenue
FROM chips_sales
GROUP BY PROD_NAME
ORDER BY revenue DESC
LIMIT 10;

-- 6. Top 10 brands by revenue
SELECT 
    BRAND,
    ROUND(SUM(TOT_SALES), 2) AS revenue
FROM chips_sales
GROUP BY BRAND
ORDER BY revenue DESC
LIMIT 10;

-- 7. Pack size performance
SELECT 
    PACK_SIZE,
    ROUND(SUM(TOT_SALES), 2) AS revenue,
    COUNT(*) AS transactions
FROM chips_sales
GROUP BY PACK_SIZE
ORDER BY revenue DESC;

-- 8. Customer segment performance
SELECT 
    LIFESTAGE,
    PREMIUM_CUSTOMER,
    ROUND(SUM(TOT_SALES), 2) AS revenue,
    COUNT(*) AS transactions,
    COUNT(DISTINCT LYLTY_CARD_NBR) AS customers,
    ROUND(AVG(TOT_SALES), 2) AS avg_transaction_value
FROM chips_sales
GROUP BY LIFESTAGE, PREMIUM_CUSTOMER
ORDER BY revenue DESC;

-- 9. Brand ranking by revenue using window function
SELECT 
    BRAND,
    ROUND(SUM(TOT_SALES), 2) AS revenue,
    RANK() OVER (ORDER BY SUM(TOT_SALES) DESC) AS revenue_rank
FROM chips_sales
GROUP BY BRAND;

-- 10. Revenue contribution percentage by brand
SELECT 
    BRAND,
    ROUND(SUM(TOT_SALES), 2) AS brand_revenue,
    ROUND(
        SUM(TOT_SALES) * 100.0 / (SELECT SUM(TOT_SALES) FROM chips_sales), 
        2
    ) AS revenue_percentage
FROM chips_sales
GROUP BY BRAND
ORDER BY brand_revenue DESC;