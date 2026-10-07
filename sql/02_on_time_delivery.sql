-- ==========================================
-- CASE STUDY 02: ON-TIME DELIVERY PERFORMANCE
-- ==========================================

-- Business Objective:
-- Identify suppliers with poor delivery reliability.

WITH delivery_performance AS (
    SELECT
        supplier_id,
        COUNT(po_id) AS total_delivered_orders,
        SUM(
            CASE
                WHEN delivery_date <= expected_date
                THEN 1 ELSE 0
            END
        ) AS on_time_orders,
        SUM(
            CASE
                WHEN delivery_date > expected_date
                THEN 1 ELSE 0
            END
        ) AS late_orders,
        ROUND(
            100.0 * SUM(
                CASE
                    WHEN delivery_date <= expected_date
                    THEN 1 ELSE 0
                END
            ) / NULLIF(COUNT(po_id), 0),
            2
        ) AS on_time_delivery_rate,
        ROUND(
            AVG(
                CASE
                    WHEN delivery_date > expected_date
                    THEN julianday(delivery_date)
                         - julianday(expected_date)
                END
            ),
            2
        ) AS avg_days_late
    FROM purchase_orders
    WHERE status = 'Delivered'
      AND delivery_date IS NOT NULL
    GROUP BY supplier_id
)

SELECT
    s.supplier_name,
    d.total_delivered_orders,
    d.on_time_orders,
    d.late_orders,
    d.on_time_delivery_rate,
    d.avg_days_late
FROM delivery_performance d
JOIN suppliers s
    ON d.supplier_id = s.supplier_id
ORDER BY d.on_time_delivery_rate ASC,
         d.avg_days_late DESC;
