mysql> CREATE DATABASE fraud_db;
Query OK, 1 row affected (0.01 sec)

mysql> USE fraud_db;
Database changed
mysql> CREATE TABLE transactions (
    ->     time INT,
    ->     amount FLOAT,
    ->     class INT
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> SHOW TABLES;
+--------------------+
| Tables_in_fraud_db |
+--------------------+
| transactions       |
+--------------------+
1 row in set (0.01 sec)

mysql> -- Insert Sample Data
mysql> INSERT INTO transactions (time, amount, class) VALUES
    -> (1000, 50.5, 0),
    -> (2000, 120.0, 0),
    -> (3000, 500.0, 1),
    -> (4000, 200.0, 0),
    -> (5000, 1500.0, 1),
    -> (6000, 70.0, 0),
    -> (7000, 900.0, 1);
Query OK, 7 rows affected (0.02 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> -- View Data
mysql> SELECT * FROM transactions;
+------+--------+-------+
| time | amount | class |
+------+--------+-------+
| 1000 |   50.5 |     0 |
| 2000 |    120 |     0 |
| 3000 |    500 |     1 |
| 4000 |    200 |     0 |
| 5000 |   1500 |     1 |
| 6000 |     70 |     0 |
| 7000 |    900 |     1 |
+------+--------+-------+
7 rows in set (0.00 sec)

mysql>
mysql> -- Total Transactions
mysql> SELECT COUNT(*) AS total_transactions FROM transactions;
+--------------------+
| total_transactions |
+--------------------+
|                  7 |
+--------------------+
1 row in set (0.01 sec)

mysql> -- Total Fraud Transactions
mysql> SELECT COUNT(*) AS fraud_count
    -> FROM transactions
    -> WHERE class = 1;
+-------------+
| fraud_count |
+-------------+
|           3 |
+-------------+
1 row in set (0.01 sec)

mysql>
mysql> -- Fraud Percentage
mysql> SELECT
    ->     (SUM(class) * 100.0) / COUNT(*) AS fraud_percentage
    -> FROM transactions;
+------------------+
| fraud_percentage |
+------------------+
|         42.85714 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT
    ->     class,
    ->     COUNT(*) AS total_count
    -> FROM transactions
    -> GROUP BY class;
+-------+-------------+
| class | total_count |
+-------+-------------+
|     0 |           4 |
|     1 |           3 |
+-------+-------------+
2 rows in set (0.00 sec)

mysql> -- Average Amount
mysql> SELECT AVG(amount) AS avg_amount FROM transactions;
+-------------------+
| avg_amount        |
+-------------------+
| 477.2142857142857 |
+-------------------+
1 row in set (0.00 sec)

mysql>
mysql> -- Avg Amount by Class
mysql> SELECT
    ->     class,
    ->     AVG(amount) AS avg_amount
    -> FROM transactions
    -> GROUP BY class;
+-------+-------------------+
| class | avg_amount        |
+-------+-------------------+
|     0 |           110.125 |
|     1 | 966.6666666666666 |
+-------+-------------------+
2 rows in set (0.00 sec)

mysql> -- Fraud Count by Hour
mysql> SELECT
    ->     FLOOR(time / 3600) AS hour,
    ->     SUM(class) AS fraud_count
    -> FROM transactions
    -> GROUP BY hour
    -> ORDER BY hour;
+------+-------------+
| hour | fraud_count |
+------+-------------+
|    0 |           1 |
|    1 |           2 |
+------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT
    ->     FLOOR(time / 3600) AS hour,
    ->     SUM(class) AS fraud_count
    -> FROM transactions
    -> GROUP BY hour
    -> ORDER BY fraud_count DESC
    -> LIMIT 5;
+------+-------------+
| hour | fraud_count |
+------+-------------+
|    1 |           2 |
|    0 |           1 |
+------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT
    ->     FLOOR(time / 3600) AS hour,
    ->     COUNT(*) AS total_txn,
    ->     SUM(class) AS fraud_txn,
    ->     (SUM(class) * 100.0) / COUNT(*) AS fraud_rate
    -> FROM transactions
    -> GROUP BY hour
    -> ORDER BY fraud_rate DESC;
+------+-----------+-----------+------------+
| hour | total_txn | fraud_txn | fraud_rate |
+------+-----------+-----------+------------+
|    1 |         4 |         2 |   50.00000 |
|    0 |         3 |         1 |   33.33333 |
+------+-----------+-----------+------------+
2 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM transactions
    -> WHERE class = 1
    -> ORDER BY amount DESC
    -> LIMIT 10;
+------+--------+-------+
| time | amount | class |
+------+--------+-------+
| 5000 |   1500 |     1 |
| 7000 |    900 |     1 |
| 3000 |    500 |     1 |
+------+--------+-------+
3 rows in set (0.00 sec)

mysql> -- Check NULL values
mysql> SELECT * FROM transactions
    -> WHERE time IS NULL OR amount IS NULL OR class IS NULL;
Empty set (0.00 sec)

mysql>