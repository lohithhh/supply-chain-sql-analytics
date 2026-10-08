-- Q08: Which carriers have the lowest transit times, on-time arrival rates, and shipping cost?
SELECT carrier, COUNT(*) AS total_shipments,
       SUM(CASE WHEN arrival_date IS NOT NULL THEN 1 ELSE 0 END) AS completed_shipments,
       ROUND(AVG(CASE WHEN arrival_date IS NOT NULL THEN julianday(arrival_date)-julianday(shipment_date) END),2) AS avg_transit_days,
       ROUND(AVG(shipping_cost),2) AS avg_shipping_cost,
       ROUND(SUM(shipping_cost),2) AS total_shipping_cost,
       ROUND(100.0*SUM(CASE WHEN sh.arrival_date IS NOT NULL AND sh.arrival_date <= po.expected_date THEN 1 ELSE 0 END)
       /NULLIF(SUM(CASE WHEN sh.arrival_date IS NOT NULL THEN 1 ELSE 0 END),0),2) AS on_time_arrival_pct
FROM shipments sh JOIN purchase_orders po USING(po_id)
GROUP BY carrier ORDER BY on_time_arrival_pct DESC, avg_transit_days ASC;
