-- ADVANCED BANKING CUSTOMER & ACCOUNT ANALYSIS | MySQL 8.0+
-- Synthetic portfolio project. This drops/recreates the database.
DROP DATABASE IF EXISTS Banking_Database;
CREATE DATABASE Banking_Database;
USE Banking_Database;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20) NOT NULL UNIQUE,
  location VARCHAR(100) NOT NULL,
  date_registered DATE NOT NULL,
  customer_status ENUM('Active','Inactive') NOT NULL DEFAULT 'Active'
);

CREATE TABLE accounts (
  account_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  account_number VARCHAR(20) NOT NULL UNIQUE,
  account_type ENUM('Savings','Current','Fixed Deposit') NOT NULL,
  opening_balance DECIMAL(14,2) NOT NULL DEFAULT 0,
  date_opened DATE NOT NULL,
  account_status ENUM('Active','Dormant','Closed') NOT NULL DEFAULT 'Active',
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CHECK (opening_balance >= 0)
);

CREATE TABLE transactions (
  transaction_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  account_id INT NOT NULL,
  transaction_date DATETIME NOT NULL,
  transaction_type ENUM('Deposit','Withdrawal','Transfer In','Transfer Out','Fee') NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  transaction_channel ENUM('Branch','ATM','Mobile App','Internet Banking','POS') NOT NULL,
  transaction_status ENUM('Completed','Pending','Failed','Reversed') NOT NULL DEFAULT 'Completed',
  description VARCHAR(255),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id),
  CHECK (amount > 0),
  INDEX idx_account_date (account_id, transaction_date),
  INDEX idx_type_status (transaction_type, transaction_status)
);

INSERT INTO customers
(customer_id,customer_name,phone_number,location,date_registered,customer_status) VALUES
(1,'John Doe','0900787887','Lagos','2023-01-15','Active'),
(2,'Jane Smith','0802222222','Abuja','2023-02-20','Active'),
(3,'Michael Johnson','0803333333','Port Harcourt','2023-03-11','Active'),
(4,'Emily Davis','0804444444','Lagos','2023-04-05','Active'),
(5,'David Brown','0805555555','Ibadan','2023-05-17','Inactive'),
(6,'Sarah Wilson','0806666666','Abuja','2023-06-22','Active'),
(7,'James Taylor','0807777777','Lagos','2023-07-08','Active'),
(8,'Patricia Anderson','0808888888','Port Harcourt','2023-08-19','Active'),
(9,'Robert Thomas','0809999999','Ibadan','2023-09-13','Active'),
(10,'Linda Jackson','0800101010','Lagos','2023-10-02','Active'),
(11,'William White','0800202020','Abuja','2023-11-25','Inactive'),
(12,'Elizabeth Harris','0803303030','Port Harcourt','2024-01-07','Active'),
(13,'Richard Martin','0804004040','Lagos','2024-02-14','Active'),
(14,'Barbara Thompson','0800505050','Ibadan','2024-03-09','Active'),
(15,'Joseph Garcia','0806006060','Abuja','2024-04-21','Active');

INSERT INTO accounts
(account_id,customer_id,account_number,account_type,opening_balance,date_opened,account_status) VALUES
(1,1,'BA10000001','Savings',15000,'2023-01-16','Active'),
(2,2,'BA10000002','Current',25000,'2023-02-21','Active'),
(3,3,'BA10000003','Savings',10000,'2023-03-12','Active'),
(4,4,'BA10000004','Current',50000,'2023-04-06','Active'),
(5,5,'BA10000005','Savings',8000,'2023-05-18','Dormant'),
(6,6,'BA10000006','Current',30000,'2023-06-23','Active'),
(7,7,'BA10000007','Savings',12000,'2023-07-09','Active'),
(8,8,'BA10000008','Current',45000,'2023-08-20','Active'),
(9,9,'BA10000009','Savings',9500,'2023-09-14','Active'),
(10,10,'BA10000010','Current',60000,'2023-10-03','Active'),
(11,11,'BA10000011','Savings',20000,'2023-11-26','Dormant'),
(12,12,'BA10000012','Current',35000,'2024-01-08','Active'),
(13,13,'BA10000013','Savings',18000,'2024-02-15','Active'),
(14,14,'BA10000014','Fixed Deposit',100000,'2024-03-10','Active'),
(15,15,'BA10000015','Savings',22000,'2024-04-22','Active');

INSERT INTO transactions
(transaction_id,account_id,transaction_date,transaction_type,amount,transaction_channel,transaction_status,description) VALUES
(1,1,'2025-01-03 09:15:00','Deposit',5000,'Mobile App','Completed','Salary deposit'),
(2,1,'2025-01-05 12:30:00','Withdrawal',2000,'ATM','Completed','Cash withdrawal'),
(3,1,'2025-01-18 14:20:00','Transfer Out',1500,'Mobile App','Completed','External transfer'),
(4,2,'2025-01-04 10:00:00','Deposit',15000,'Branch','Completed','Business deposit'),
(5,2,'2025-01-07 16:10:00','Withdrawal',5000,'Internet Banking','Completed','Supplier payment'),
(6,2,'2025-01-21 11:00:00','Fee',500,'Internet Banking','Completed','Account fee'),
(7,3,'2025-01-08 08:45:00','Deposit',3000,'Mobile App','Completed','Personal deposit'),
(8,3,'2025-01-09 13:30:00','Withdrawal',1000,'ATM','Completed','Cash withdrawal'),
(9,4,'2025-01-02 09:00:00','Deposit',25000,'Branch','Completed','Business income'),
(10,4,'2025-01-12 15:45:00','Transfer Out',8000,'Internet Banking','Completed','Supplier transfer'),
(11,5,'2024-10-10 12:00:00','Withdrawal',500,'ATM','Completed','Cash withdrawal'),
(12,6,'2025-01-06 10:30:00','Deposit',7000,'Mobile App','Completed','Customer payment'),
(13,6,'2025-01-16 12:40:00','Withdrawal',2500,'POS','Completed','Retail purchase'),
(14,7,'2025-01-11 17:00:00','Deposit',4000,'Mobile App','Completed','Personal deposit'),
(15,7,'2025-01-14 09:30:00','Withdrawal',3000,'ATM','Completed','Cash withdrawal'),
(16,8,'2025-01-05 11:15:00','Deposit',10000,'Branch','Completed','Business deposit'),
(17,8,'2025-01-20 14:10:00','Transfer Out',9000,'Internet Banking','Completed','Supplier transfer'),
(18,9,'2025-01-13 08:20:00','Deposit',2500,'Mobile App','Completed','Personal deposit'),
(19,9,'2025-01-19 19:00:00','Withdrawal',1500,'ATM','Completed','Cash withdrawal'),
(20,10,'2025-01-03 10:10:00','Deposit',20000,'Branch','Completed','Business revenue'),
(21,10,'2025-01-22 13:00:00','Transfer Out',12000,'Internet Banking','Completed','Vendor payment'),
(22,12,'2025-01-09 09:50:00','Deposit',6000,'Mobile App','Completed','Customer payment'),
(23,12,'2025-01-17 16:20:00','Fee',750,'Internet Banking','Completed','Service fee'),
(24,13,'2025-01-10 12:15:00','Deposit',4500,'Mobile App','Completed','Personal deposit'),
(25,13,'2025-01-24 15:30:00','Withdrawal',1200,'POS','Completed','Retail purchase'),
(26,14,'2025-01-01 08:00:00','Deposit',10000,'Branch','Completed','Fixed deposit top-up'),
(27,15,'2025-01-15 11:30:00','Deposit',5500,'Mobile App','Pending','Pending deposit'),
(28,15,'2025-01-16 12:00:00','Deposit',2500,'Mobile App','Completed','Personal deposit'),
(29,6,'2025-01-18 14:00:00','Withdrawal',1000,'ATM','Failed','Failed cash withdrawal'),
(30,8,'2025-01-25 18:00:00','Withdrawal',1200,'POS','Reversed','Reversed POS transaction');

-- A. Customer-account detail
SELECT c.customer_id,c.customer_name,c.location,a.account_number,a.account_type,a.account_status
FROM customers c JOIN accounts a ON a.customer_id=c.customer_id
ORDER BY c.customer_name;

-- B. Customers without accounts (useful if customer/account cardinality changes)
SELECT c.customer_id,c.customer_name,c.location
FROM customers c LEFT JOIN accounts a ON a.customer_id=c.customer_id
WHERE a.account_id IS NULL;

-- C. Calculate balances from opening balance plus completed transactions only
WITH transaction_effect AS (
  SELECT account_id,
    SUM(CASE
      WHEN transaction_type IN ('Deposit','Transfer In') THEN amount
      WHEN transaction_type IN ('Withdrawal','Transfer Out','Fee') THEN -amount
      ELSE 0 END) AS net_amount
  FROM transactions
  WHERE transaction_status='Completed'
  GROUP BY account_id
)
SELECT c.customer_name,a.account_number,a.account_type,a.opening_balance,
       COALESCE(te.net_amount,0) AS net_transaction_amount,
       a.opening_balance+COALESCE(te.net_amount,0) AS calculated_balance
FROM accounts a
JOIN customers c ON c.customer_id=a.customer_id
LEFT JOIN transaction_effect te ON te.account_id=a.account_id
ORDER BY calculated_balance DESC;

-- D. Deposit, withdrawal/transfer-out and fee totals
SELECT
  SUM(CASE WHEN transaction_type IN ('Deposit','Transfer In') THEN amount ELSE 0 END) AS total_money_in,
  SUM(CASE WHEN transaction_type IN ('Withdrawal','Transfer Out') THEN amount ELSE 0 END) AS total_money_out,
  SUM(CASE WHEN transaction_type='Fee' THEN amount ELSE 0 END) AS total_fees
FROM transactions
WHERE transaction_status='Completed';

-- E. Customer distribution by location
SELECT location,COUNT(*) AS customer_count
FROM customers GROUP BY location
ORDER BY customer_count DESC;

-- F. Account-type summary, using calculated balances
WITH transaction_effect AS (
  SELECT account_id,
    SUM(CASE
      WHEN transaction_type IN ('Deposit','Transfer In') THEN amount
      WHEN transaction_type IN ('Withdrawal','Transfer Out','Fee') THEN -amount
      ELSE 0 END) AS net_amount
  FROM transactions WHERE transaction_status='Completed'
  GROUP BY account_id
)
SELECT a.account_type,COUNT(*) AS account_count,
       SUM(a.opening_balance+COALESCE(te.net_amount,0)) AS total_calculated_balance,
       AVG(a.opening_balance+COALESCE(te.net_amount,0)) AS average_calculated_balance
FROM accounts a LEFT JOIN transaction_effect te ON te.account_id=a.account_id
GROUP BY a.account_type ORDER BY total_calculated_balance DESC;

-- G. Monthly transaction count and value
SELECT DATE_FORMAT(transaction_date,'%Y-%m') AS transaction_month,
       COUNT(*) AS transaction_count,SUM(amount) AS transaction_value
FROM transactions WHERE transaction_status='Completed'
GROUP BY DATE_FORMAT(transaction_date,'%Y-%m')
ORDER BY transaction_month;

-- H. Preferred transaction channels
SELECT transaction_channel,COUNT(*) AS transaction_count,SUM(amount) AS total_value
FROM transactions WHERE transaction_status='Completed'
GROUP BY transaction_channel ORDER BY transaction_count DESC;

-- I. Rank accounts by balance using a window function
WITH transaction_effect AS (
  SELECT account_id,
    SUM(CASE
      WHEN transaction_type IN ('Deposit','Transfer In') THEN amount
      WHEN transaction_type IN ('Withdrawal','Transfer Out','Fee') THEN -amount
      ELSE 0 END) AS net_amount
  FROM transactions WHERE transaction_status='Completed'
  GROUP BY account_id
),
balances AS (
  SELECT c.customer_id,c.customer_name,c.location,a.account_number,a.account_type,
         a.opening_balance+COALESCE(te.net_amount,0) AS calculated_balance
  FROM customers c JOIN accounts a ON a.customer_id=c.customer_id
  LEFT JOIN transaction_effect te ON te.account_id=a.account_id
)
SELECT *,DENSE_RANK() OVER (ORDER BY calculated_balance DESC) AS balance_rank
FROM balances ORDER BY balance_rank;

-- J. Segment accounts by balance
WITH transaction_effect AS (
  SELECT account_id,
    SUM(CASE
      WHEN transaction_type IN ('Deposit','Transfer In') THEN amount
      WHEN transaction_type IN ('Withdrawal','Transfer Out','Fee') THEN -amount
      ELSE 0 END) AS net_amount
  FROM transactions WHERE transaction_status='Completed'
  GROUP BY account_id
),
balances AS (
  SELECT a.account_id,a.opening_balance+COALESCE(te.net_amount,0) AS calculated_balance
  FROM accounts a LEFT JOIN transaction_effect te ON te.account_id=a.account_id
)
SELECT CASE
         WHEN calculated_balance < 10000 THEN 'Low balance'
         WHEN calculated_balance < 50000 THEN 'Medium balance'
         ELSE 'High balance'
       END AS balance_segment,
       COUNT(*) AS account_count,SUM(calculated_balance) AS segment_balance
FROM balances GROUP BY balance_segment ORDER BY segment_balance DESC;

-- K. Customers with more than one completed transaction
SELECT c.customer_id,c.customer_name,COUNT(t.transaction_id) AS completed_transactions,
       SUM(t.amount) AS transaction_value
FROM customers c
JOIN accounts a ON a.customer_id=c.customer_id
JOIN transactions t ON t.account_id=a.account_id
WHERE t.transaction_status='Completed'
GROUP BY c.customer_id,c.customer_name
HAVING COUNT(t.transaction_id)>1
ORDER BY completed_transactions DESC,transaction_value DESC;

-- L. Failed and reversed transaction monitoring
SELECT t.transaction_id,c.customer_name,a.account_number,t.transaction_date,
       t.transaction_type,t.amount,t.transaction_channel,t.transaction_status
FROM transactions t
JOIN accounts a ON a.account_id=t.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.transaction_status IN ('Failed','Reversed')
ORDER BY t.transaction_date DESC;

-- M. Latest completed transaction for each account (window function)
WITH ranked_transactions AS (
  SELECT t.account_id,t.transaction_date,t.transaction_type,t.amount,
         ROW_NUMBER() OVER (
           PARTITION BY t.account_id
           ORDER BY t.transaction_date DESC,t.transaction_id DESC
         ) AS row_num
  FROM transactions t
  WHERE t.transaction_status='Completed'
)
SELECT c.customer_name,a.account_number,rt.transaction_date AS last_completed_transaction,
       rt.transaction_type,rt.amount
FROM accounts a JOIN customers c ON c.customer_id=a.customer_id
LEFT JOIN ranked_transactions rt ON rt.account_id=a.account_id AND rt.row_num=1
ORDER BY last_completed_transaction;

-- N. Data quality: duplicate phone audit (normally returns no rows)
SELECT phone_number,COUNT(*) AS occurrences
FROM customers GROUP BY phone_number HAVING COUNT(*)>1;

-- O. Reusable account balance report
CREATE VIEW vw_account_balance_report AS
WITH transaction_effect AS (
  SELECT account_id,
    SUM(CASE
      WHEN transaction_type IN ('Deposit','Transfer In') THEN amount
      WHEN transaction_type IN ('Withdrawal','Transfer Out','Fee') THEN -amount
      ELSE 0 END) AS net_amount
  FROM transactions WHERE transaction_status='Completed'
  GROUP BY account_id
)
SELECT c.customer_id,c.customer_name,c.location,a.account_number,a.account_type,a.account_status,
       a.opening_balance,COALESCE(te.net_amount,0) AS net_transaction_amount,
       a.opening_balance+COALESCE(te.net_amount,0) AS calculated_balance
FROM customers c JOIN accounts a ON a.customer_id=c.customer_id
LEFT JOIN transaction_effect te ON te.account_id=a.account_id;

SELECT * FROM vw_account_balance_report ORDER BY calculated_balance DESC;

-- Portfolio note: this is synthetic sample data, not real banking information.
