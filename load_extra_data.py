import sqlite3
from pathlib import Path
base = Path(__file__).resolve().parent
with sqlite3.connect(base / 'database' / 'supply_chain.db') as connection:
    connection.execute('PRAGMA foreign_keys = ON')
    connection.executescript((base / 'database' / 'extra_data.sql').read_text(encoding='utf-8'))
    for table in ('inventory', 'shipments'):
        print(f'{table}: {connection.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]} rows')
