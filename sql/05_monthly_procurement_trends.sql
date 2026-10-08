-- Q05: How does ordered procurement value change month over month?
WITH monthly AS (
 SELECT strftime('%Y-%m', order_date) AS order_month, COUNT(*) AS total_orders,
        ROUND(SUM(quantity * unit_cost),2) AS total_spend
 FROM purchase_orders GROUP BY strftime('%Y-%m',order_date)
), trends AS (
 SELECT *, LAG(total_spend) OVER (ORDER BY order_month) AS previous_month_spend FROM monthly
)
SELECT order_month, total_orders, total_spend, previous_month_spend,
       ROUND(total_spend-previous_month_spend,2) AS spend_change,
       ROUND(100.0*(total_spend-previous_month_spend)/NULLIF(previous_month_spend,0),2) AS spend_change_pct
FROM trends ORDER BY order_month;
