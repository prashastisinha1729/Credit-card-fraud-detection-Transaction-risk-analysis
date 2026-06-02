import pandas as pd
import mysql.connector

# Read CSV
df = pd.read_csv(r"E:\fraud-detection-project\data\creditcard.csv")

# Connect MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="fraud_db"
)

cursor = conn.cursor()

# 31 placeholders
query = """
INSERT INTO transactions VALUES (
%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,
%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,
%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s
)
"""

chunk_size = 1000

for start in range(0, len(df), chunk_size):
    end = start + chunk_size

    chunk = [tuple(row) for row in df.iloc[start:end].values]

    cursor.executemany(query, chunk)
    conn.commit()

    print(f"Imported {min(end, len(df))} rows")

print("Data Imported Successfully!")

cursor.close()
conn.close()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             