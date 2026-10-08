-- Q04: Which suppliers have the largest share of ordered procurement value?
WITH supplier_spend AS (
 SELECT supplier_id, COUNT(*) AS total_orders, SUM(quantity) AS total_quantity,
        ROUND(SUM(quantity * unit_cost),2) AS total_spend
 FROM purchase_orders GROUP BY supplier_id
), ranked AS (
 SELECT *, ROUND(100.0 * total_spend / NULLIF(SUM(total_spend) OVER (),0),2) AS percentage_of_total_spend,
 RANK() OVER (ORDER BY total_spend DESC) AS spend_rank FROM supplier_spend
)
SELECT s.supplier_name, r.total_orders, r.total_quantity, r.total_spend,
       r.percentage_of_total_spend, r.spend_rank
FROM ranked r JOIN suppliers s USING(supplier_id)
ORDER BY spend_rank, supplier_name;
