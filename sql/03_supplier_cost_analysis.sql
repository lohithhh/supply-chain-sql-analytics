-- ==========================================
-- CASE STUDY 03: SUPPLIER COST ANALYSIS
-- ==========================================

-- Business Objective:
-- Analyze changes in supplier unit costs
-- over time for the same product.

WITH cost_history AS (
    SELECT
        supplier_id,
        product_id,
        po_id,
        order_date,
        unit_cost,
        LAG(unit_cost) OVER (
            PARTITION BY supplier_id, product_id
            ORDER BY order_date, po_id
        ) AS previous_unit_cost
    FROM purchase_orders
),
cost_analysis AS (
    SELECT
        supplier_id,
        product_id,
        order_date,
        unit_cost,
        previous_unit_cost,
        unit_cost - previous_unit_cost
            AS cost_change,
        ROUND(
            (unit_cost - previous_unit_cost)
            * 100.0
            / NULLIF(previous_unit_cost, 0),
            2
        ) AS cost_change_percentage
    FROM cost_history
)

SELECT
    s.supplier_name,
    p.product_name,
    c.order_date,
    c.unit_cost,
    c.previous_unit_cost,
    c.cost_change,
    c.cost_change_percentage
FROM cost_analysis c
JOIN suppliers s
    ON c.supplier_id = s.supplier_id
JOIN products p
    ON c.product_id = p.product_id
ORDER BY
    s.supplier_name,
    p.product_name,
    c.order_date;
