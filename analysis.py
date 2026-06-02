import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# Connect to MySQL
conn = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="YOUR_PASSWORD",
    database="fraud_db"
)

# Query data
query = "SELECT * FROM transactions"
df = pd.read_sql(query, conn)

# Show data
print(df.head())

# Fraud count
fraud_count = df['class'].value_counts()
print(fraud_count)

# Plot
fraud_count.plot(kind='bar')
plt.title("Fraud vs Normal Transactions")
plt.xlabel("Class (0 = Normal, 1 = Fraud)")
plt.ylabel("Count")
plt.show()