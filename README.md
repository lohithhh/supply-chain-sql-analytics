# Supply Chain SQL Analytics

## Project Overview

This project demonstrates how SQL and Python can be used to analyze supply chain procurement operations, evaluate supplier performance, monitor purchasing costs, and support data-driven business decisions.

The project uses a synthetic manufacturing procurement dataset and SQLite to simulate real-world supply chain analytics scenarios.

## Business Objectives

- Evaluate supplier delivery lead times.
- Measure supplier on-time delivery performance.
- Analyze historical supplier unit-cost changes.
- Identify procurement risks and opportunities for operational improvement.
- Develop reusable SQL queries for business reporting.

## Technologies Used

- **SQL (SQLite)** — Data querying and analysis
- **Python** — Database creation, data loading, and query execution
- **SQLite3** — Relational database management
- **PyCharm** — Development environment
- **Git & GitHub** — Version control and portfolio hosting

## Database Structure

The database includes six relational tables:

| Table | Description |
|---|---|
| suppliers | Supplier information and country |
| products | Product details, categories, and prices |
| warehouses | Warehouse locations |
| purchase_orders | Purchase order, cost, and delivery information |
| inventory | Inventory quantities and reorder levels |
| shipments | Shipment and transportation information |

The current sample dataset contains 8 suppliers, 8 products, 4 warehouses, and 30 purchase orders.

The inventory and shipments tables are defined in the schema but are not yet populated with sample data.

## Completed SQL Case Studies

### 01 — Supplier Lead Time Analysis

**Business Question:** Which suppliers have the longest delivery lead times?

Calculates average, minimum, and maximum delivery lead times by supplier.

Key findings:
- Pacific Components and Asia Electronics have the longest average lead times at 17 days.
- ABC Manufacturing has the shortest average lead time at 6.67 days.

**SQL Concepts:** CTEs, JOINs, AVG(), MIN(), MAX(), COUNT(), date calculations.

### 02 — On-Time Delivery Performance

**Business Question:** Which suppliers consistently meet their expected delivery dates?

Calculates on-time delivery rates, late order counts, and average days late.

Key findings:
- Overall on-time delivery rate: 37.5%.
- 15 of 24 completed orders were delivered late.
- Global Steel Ltd had the highest average delay at 4.67 days.

**SQL Concepts:** Conditional aggregation, CASE, CTEs, JOINs, NULLIF().

### 03 — Supplier Cost Analysis

**Business Question:** How have supplier purchasing prices changed over time?

Uses SQL window functions to compare historical unit costs for the same supplier and product.

Key findings:
- Northern Materials recorded a 20% cumulative unit-cost increase.
- Global Steel Ltd recorded a 17.5% cumulative increase.
- All eight suppliers showed increasing recorded unit costs.

**SQL Concepts:** LAG(), PARTITION BY, ORDER BY, CTEs, JOINs, percentage calculations.

## How to Run the Project

### Requirements

- Python 3
- SQLite3 (included with standard Python installations)

### Setup

Clone the repository and navigate into the project folder.

Create the database schema:

```bash
python setup_database.py
```

Load supplier, product, and warehouse sample data:

```bash
python load_data.py
```

Load purchase orders:

```bash
python load_purchase_orders.py
```

### Run SQL Case Studies

Supplier Lead Time Analysis:

```bash
python run_query.py sql/01_supplier_lead_time.sql
```

On-Time Delivery Performance:

```bash
python run_query.py sql/02_on_time_delivery.sql
```

Supplier Cost Analysis:

```bash
python run_query.py sql/03_supplier_cost_analysis.sql
```

The scripts use Python's built-in `sqlite3` library to execute SQL against the local SQLite database.

## Business Insights

Detailed analysis and recommendations are documented in:

`insights/business_findings.md`

These findings demonstrate how procurement analysts can use supplier performance and purchasing data to identify operational risks.

## Future Enhancements

- Procurement spending analysis
- Supplier cost impact analysis
- Inventory and reorder-level analysis
- Shipment performance analysis
- Power BI dashboards
- Additional synthetic data for more realistic performance metrics

## Data Disclaimer

All data used in this project is synthetic and intended for educational and portfolio demonstration purposes. Results do not represent actual suppliers or business operations.

## Project Status

**In Progress** — Three SQL case studies completed. Additional procurement, inventory, and shipment analyses are planned.