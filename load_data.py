import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

DB_PATH = BASE_DIR / "database" / "supply_chain.db"
DATA_PATH = BASE_DIR / "database" / "sample_data.sql"

with sqlite3.connect(DB_PATH) as connection:
    connection.execute("PRAGMA foreign_keys = ON")

    # Prevent duplicate sample-data loading
    existing = connection.execute(
        "SELECT COUNT(*) FROM suppliers"
    ).fetchone()[0]

    if existing > 0:
        print("Sample data already loaded.")
    else:
        connection.executescript(
            DATA_PATH.read_text(encoding="utf-8")
        )
        print("Sample data loaded successfully!")

    for table in ["suppliers", "products", "warehouses"]:
        count = connection.execute(
            f"SELECT COUNT(*) FROM {table}"
        ).fetchone()[0]

        print(f"{table}: {count} records")
