-- Q07: Which warehouses have the highest ordered procurement value and delivery reliability?
SELECT w.warehouse_name, w.location, COUNT(po.po_id) AS total_orders,
       SUM(po.quantity) AS total_ordered_units,
       ROUND(SUM(po.quantity*po.unit_cost),2) AS total_ordered_value,
       SUM(CASE WHEN po.status='Delivered' AND po.delivery_date IS NOT NULL THEN 1 ELSE 0 END) AS delivered_orders,
       ROUND(100.0*SUM(CASE WHEN po.status='Delivered' AND po.delivery_date IS NOT NULL AND po.delivery_date <= po.expected_date THEN 1 ELSE 0 END)
       /NULLIF(SUM(CASE WHEN po.status='Delivered' AND po.delivery_date IS NOT NULL THEN 1 ELSE 0 END),0),2) AS on_time_delivery_pct
FROM warehouses w LEFT JOIN purchase_orders po USING(warehouse_id)
GROUP BY w.warehouse_id, w.warehouse_name, w.location
ORDER BY total_ordered_value DESC;
