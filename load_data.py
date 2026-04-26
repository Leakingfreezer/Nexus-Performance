import pandas as pd
import sqlite3

# 1. Load CSV
csv_path = "data/hevy_export.csv"
df = pd.read_csv(csv_path)

# 2. Preview data
print("Original columns:")
print(df.columns)

print("\nFirst 5 rows:")
print(df.head())

# 3. Clean column names
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("(", "", regex=False)
    .str.replace(")", "", regex=False)
    .str.replace("/", "_")
)

print("\nCleaned columns:")
print(df.columns)

# 4. Create/connect to SQLite database
db_path = "hyrox_training.db"
conn = sqlite3.connect(db_path)

# 5. Save CSV data into SQL table
df.to_sql("hevy_raw", conn, if_exists="replace", index=False)

# 6. Confirm it worked
test = pd.read_sql("SELECT * FROM hevy_raw LIMIT 5;", conn)
print("\nData loaded into SQLite:")
print(test)

conn.close()

print("\nDone! Created hyrox_training.db with table: hevy_raw")