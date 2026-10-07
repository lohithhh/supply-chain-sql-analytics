
import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "database" / "supply_chain.db"

with sqlite3.connect(DB_PATH) as connection:
    connection.execute("PRAGMA foreign_keys = ON")

    existing = connection.execute(
        "SELECT COUNT(*) FROM purchase_orders"
    ).fetchone()[0]

    if existing > 0:
        print("Purchase orders already loaded.")
    else:
        # Execute only the purchase-order section
        sql = (
            BASE_DIR / "database" / "sample_data.sql"
        ).read_text(encoding="utf-8")

        purchase_order_sql = sql.split(
            "-- PURCHASE ORDERS"
        )[1]

        connection.executescript(purchase_order_sql)

        print("Purchase orders loaded successfully!")

    count = connection.execute(
        "SELECT COUNT(*) FROM purchase_orders"
    ).fetchone()[0]

    print(f"Total purchase orders: {count}")
