-- ==========================================
-- CASE STUDY 01: SUPPLIER LEAD TIME ANALYSIS
-- ==========================================

-- Business Objective:
-- Identify suppliers with the longest
-- average delivery lead times.

WITH supplier_lead_time AS (
    SELECT
        supplier_id,
        COUNT(po_id) AS total_delivered_orders,
        ROUND(
            AVG(
                julianday(delivery_date)
                - julianday(order_date)
            ),
            2
        ) AS avg_lead_time_days,
        MIN(
            julianday(delivery_date)
            - julianday(order_date)
        ) AS min_lead_time_days,
        MAX(
            julianday(delivery_date)
            - julianday(order_date)
        ) AS max_lead_time_days
    FROM purchase_orders
    WHERE status = 'Delivered'
      AND delivery_date IS NOT NULL
    GROUP BY supplier_id
)

SELECT
    s.supplier_name,
    l.total_delivered_orders,
    l.avg_lead_time_days,
    l.min_lead_time_days,
    l.max_lead_time_days
FROM supplier_lead_time l
JOIN suppliers s
    ON l.supplier_id = s.supplier_id
ORDER BY l.avg_lead_time_days DESC;
