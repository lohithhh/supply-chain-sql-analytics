-- Q06: Which product/warehouse combinations need replenishment?
SELECT w.warehouse_name, p.product_name, i.stock_quantity, i.reorder_level,
       CASE WHEN i.stock_quantity <= i.reorder_level THEN 'Reorder' ELSE 'Sufficient' END AS stock_status,
       MAX(i.reorder_level-i.stock_quantity,0) AS units_below_reorder_level
FROM inventory i JOIN products p USING(product_id) JOIN warehouses w USING(warehouse_id)
ORDER BY CASE WHEN i.stock_quantity <= i.reorder_level THEN 0 ELSE 1 END,
         units_below_reorder_level DESC, w.warehouse_name, p.product_name;
