import sqlite3
import sys
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "database" / "supply_chain.db"

if len(sys.argv) > 1:
    sql_file = Path(sys.argv[1])
else:
    sql_file = BASE_DIR / "sql" / "02_on_time_delivery.sql"

if not sql_file.is_absolute():
    sql_file = BASE_DIR / sql_file

query = sql_file.read_text(encoding="utf-8")

with sqlite3.connect(DB_PATH) as connection:
    connection.row_factory = sqlite3.Row
    cursor = connection.execute(query)

    columns = [column[0] for column in cursor.description]
    rows = cursor.fetchall()

print(" | ".join(columns))
print("-" * 85)

for row in rows:
    print(" | ".join(str(value) for value in row))

print(f"\nTotal records returned: {len(rows)}")
