import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "database" / "supply_chain.db"
SCHEMA_PATH = BASE_DIR / "database" / "schema.sql"

DB_PATH.parent.mkdir(parents=True, exist_ok=True)

with sqlite3.connect(DB_PATH) as connection:
    connection.executescript(
        SCHEMA_PATH.read_text(encoding="utf-8")
    )

    tables = connection.execute("""
        SELECT name
        FROM sqlite_master
        WHERE type = 'table'
        ORDER BY name
    """).fetchall()

print("Database schema created successfully!")

for table in tables:
    print(table[0])
