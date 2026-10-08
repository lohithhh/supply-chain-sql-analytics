# Supply Chain Analytics — Business Findings

## Case Study 01: Supplier Lead Time Analysis

### Business Objective
Identify suppliers with the longest average delivery lead times and highlight potential procurement risks.

### Dataset
- 8 suppliers
- 30 purchase orders
- 24 delivered purchase orders
- 6 pending purchase orders
- Synthetic manufacturing procurement data

### Key Findings
1. Pacific Components and Asia Electronics have the longest average delivery lead times at 17 days.
2. TechParts Solutions follows with an average lead time of 16.67 days.
3. ABC Manufacturing has the shortest average lead time at 6.67 days.
4. Each supplier has 3 delivered purchase orders in the dataset.

### Business Recommendations
- Investigate whether suppliers with longer lead times are meeting their agreed delivery schedules.
- Compare historical lead times against expected delivery dates.
- Consider longer procurement planning windows for suppliers with consistently longer lead times.
- Evaluate supplier delivery reliability before recommending sourcing changes.

### Tools and Techniques
- SQLite
- SQL JOINs
- Common Table Expressions (CTEs)
- AVG(), MIN(), MAX(), COUNT()
- Date calculations using julianday()
- Python sqlite3

### Limitations
The dataset is synthetic, and each supplier has only three completed deliveries. Results illustrate analytical methods rather than establish statistically reliable supplier performance.

## Case Study 02: Supplier On-Time Delivery Performance

### Business Objective
Evaluate supplier delivery reliability and identify suppliers with consistently delayed deliveries.

### Key Performance Indicators
- Total delivered orders: 24
- On-time deliveries: 9
- Late deliveries: 15
- Overall on-time delivery rate: 37.50%
- Overall late delivery rate: 62.50%

### Key Findings
1. Five of eight suppliers recorded a 0% on-time delivery rate across their three completed orders.
2. Global Steel Ltd recorded the highest average delay at 4.67 days.
3. Pacific Components and Asia Electronics each averaged 4 days late.
4. ABC Manufacturing, Prime Industrial, and Northern Materials achieved 100% on-time delivery across their completed orders.

### Business Recommendations
- Investigate recurring delays among the five suppliers with late deliveries.
- Review contractual delivery expectations and transportation processes.
- Evaluate whether procurement planning should account for historical supplier delays.
- Continue monitoring delivery reliability using larger datasets and monthly performance trends.

### SQL Techniques
- Common Table Expressions (CTEs)
- INNER JOIN
- CASE expressions
- Conditional aggregation
- COUNT(), SUM(), AVG()
- SQLite julianday()
- NULLIF() for safe division

### Data Limitation
Results are based on synthetic purchase orders. Each supplier has only three completed deliveries, limiting the reliability of supplier-level conclusions.

## Case Study 03: Supplier Cost Analysis

### Business Objective
Analyze historical supplier unit-cost changes to identify purchasing price increases and potential procurement cost risks.

### Key Findings
1. Northern Materials recorded the highest cumulative unit-cost increase at 20%, from $30 to $36.
2. Global Steel Ltd recorded the second-highest increase at 17.5%, from $40 to $47.
3. All eight suppliers showed increases in recorded unit costs over the sample period.
4. Precision Supply Co had the lowest cumulative percentage increase at approximately 5.13%.
5. Unit-cost increases should be evaluated alongside purchasing quantities to determine their financial impact.

### Business Recommendations
- Prioritize reviewing price changes at Northern Materials and Global Steel Ltd.
- Compare supplier prices with market benchmarks and contractual pricing agreements.
- Evaluate the financial impact of price changes using purchasing quantities.
- Monitor unit-cost trends regularly to identify unexpected increases.

### SQL Techniques
- LAG() window function
- PARTITION BY and ORDER BY
- Common Table Expressions (CTEs)
- Multiple-table JOINs
- Percentage-change calculations
- NULLIF() for safe division

### Limitations
The dataset is synthetic. Unit-cost comparisons use the earliest and latest recorded orders for the same supplier and product. These results do not account for inflation, product specification changes, supplier contracts, or external market conditions.


## 04 — Procurement Spend
**Question:** Which suppliers account for the largest ordered procurement value?

**Answer:** Total ordered value across 30 POs is **$470,285**. Prime Industrial is the largest supplier by ordered value at **$77,525 (16.48%)**. Supplier rankings and shares are computed in `sql/04_procurement_spend.sql`.

**Recommendation:** Review supplier spend concentration and prioritize negotiations based on spend and delivery reliability together.

## 05 — Monthly Procurement Trends
**Question:** How does ordered value change each month?

**Answer:** June 2026 has the highest ordered value (**$117,200**), up **66.48%** from May (**$70,400**). June includes pending POs, so this is **ordered value**, not completed deliveries or payments.

**Recommendation:** Investigate demand, purchasing volume, and unit-price drivers behind spikes.

## 06 — Inventory and Reorder
**Question:** Which warehouse-product combinations have stock at or below reorder level?

**Answer:** **14 of 32** synthetic warehouse-product stock records are at or below their reorder threshold. The most severe shortage against the threshold is **Control Module at Denver Distribution Center: 3 units on hand versus a reorder level of 25**, a gap of 22 units.

**Recommendation:** Review flagged records for replenishment; actual order quantities require demand forecasts, safety stock, lead times, and existing inbound orders.

## 07 — Warehouse Performance
**Question:** Which warehouses have the highest ordered value, and how reliable are deliveries?

**Answer:** Dallas Logistics Hub has the highest ordered value (**$130,050), followed by Denver ($127,525**). Denver's on-time rate is 100% among its six delivered POs; Dallas and Atlanta have 0% among their delivered POs. These rates reflect the **supplier/order mix assigned to each warehouse**, not necessarily warehouse operational efficiency.

**Recommendation:** Distinguish supplier inbound delivery performance from warehouse internal processing KPIs.

## 08 — Shipment and Logistics
**Question:** Which synthetic carrier has the shortest transit time and what is the shipping cost?

**Answer:** All three carriers have eight completed shipments. DHL has the shortest average transit time (**3.75 days**) and lowest average shipping cost (**$91.50); UPS averages 3.88 days / $111.75**, FedEx **4.13 days / $107.25**. All three show 37.5% arrivals on or before the PO expected date.

**Recommendation:** In real data, assess route, weight, distance, shipment service levels, and sample size before selecting carriers. Carrier assignments and costs here were synthetically generated and do not establish real carrier performance.

## Method and limitations
- Data is invented for SQL portfolio practice, not real-world supplier or carrier performance.
- Cases 04–05 and 07 use 30 existing purchase orders; Cases 06 and 08 require `database/extra_data.sql` (32 inventory rows and 24 shipment rows).
- Inventory threshold comparisons use `stock_quantity <= reorder_level`. Being below a reorder level is not necessarily a stockout.
- On-time shipment arrival compares `arrival_date` with PO `expected_date` for demonstration; real shipment SLAs may differ.
- Supplier on-time performance uses delivered POs only. All percentages are based on small samples.

