-- Setting the working database
USE bank;

-- ==================================================
-- Temporary Tables
-- ==================================================
-- A temporary table is a short-lived table that exists only for the duration of a session or a specific task within that session.

-- Creating a temporary table 'loan_and_account' to store combined details of loan and account.
CREATE TEMPORARY TABLE bank.loan_and_account
SELECT l.loan_id, l.account_id, a.district_id, l.amount, l.payments, a.frequency
FROM bank.loan l
JOIN bank.account a
ON l.account_id = a.account_id;

-- Fetching all records from the newly created temporary table 'loan_and_account'.
SELECT * FROM bank.loan_and_account;

-- Creating another temporary table 'disp_and_account' to store combined details of disp and account.
CREATE TEMPORARY TABLE bank.disp_and_account
SELECT d.disp_id, d.client_id, d.account_id, a.district_id, d.type
FROM bank.disp d
JOIN bank.account a
ON d.account_id = a.account_id;

-- Fetching all records from the newly created temporary table 'disp_and_account'.
SELECT * FROM bank.disp_and_account;

-- ==================================================
-- CTEs (Common Table Expressions)
-- ==================================================
-- A CTE provides a way to define a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement.

-- A very simple example to show the general syntax
-- The query after the AS keyword can be any query (from a simple to a very complex)

-- Using a CTE to fetch data from the 'loan' table where status is 'B'.
WITH cte_loan AS (
  SELECT * FROM bank.loan
)
SELECT * FROM cte_loan
WHERE status = 'B';

-- The same result can be achieved without the CTE, as shown below:
SELECT * FROM bank.loan
WHERE status = 'B';

-- Suppose that we want to find total amount and total balance per customer in the 
-- transactions table and store it into a CTE. 
-- Then pull more info on those customers by using a join between the CTE and the account table.

-- Let's start computing the total amount and balance for each account_id
-- For each 'account_id' in the 'trans' table, this query calculates the total amount and total balance.

SELECT account_id, 
       ROUND(SUM(amount),2) AS Total_amount, 
       ROUND(SUM(balance),2) AS Total_balance
FROM bank.trans
GROUP BY account_id;

-- Using CTE to aggregate data from 'trans' table and then joining with 'account' table.
WITH cte_transactions AS (
  SELECT account_id, ROUND(SUM(amount),2) AS Total_amount, ROUND(SUM(balance),2) AS Total_balance
  FROM bank.trans
  GROUP BY account_id
)
SELECT 
       ct.account_id, 
       ct.Total_amount, 
       ct.Total_balance, 
       a.district_id, 
       a.frequency,
       a.date
FROM cte_transactions AS ct
JOIN bank.account a
ON ct.account_id = a.account_id;

-- ==================================================
-- CHECK FOR UNDERSTANDING
-- ==================================================
-- Find the most active customer for each district in Central Bohemia using at least one CTE.
-- most_active_customer -> the customer who made the most transactions.

-- 1st solution, with 2 CTE
WITH trans_per_district AS (
    SELECT 
        account_id, 
        district_id, 
        COUNT(trans_id) AS trans_count
    FROM trans
    JOIN account USING (account_id)
    JOIN district ON district_id = A1
    WHERE A3 = 'central Bohemia'
    GROUP BY account_id, district_id
),
max_trans_per_district AS (
    SELECT district_id, MAX(trans_count) AS max_trans_count
    FROM trans_per_district
    GROUP BY district_id
)
SELECT t.account_id, t.district_id, t.trans_count
FROM trans_per_district t
JOIN max_trans_per_district m
ON t.district_id = m.district_id AND t.trans_count = m.max_trans_count
ORDER BY district_id;

-- alternative solution, no CTE, 1 VIEW, 1 TEMPORARY TABLE
CREATE VIEW trans_per_district AS 
SELECT 
account_id, 
district_id, 
COUNT(trans_id) AS trans_count
FROM trans
JOIN account USING (account_id)
JOIN district ON district_id = A1
WHERE A3 = 'central Bohemia'
GROUP BY account_id, district_id;

CREATE TEMPORARY TABLE max_trans_per_district AS -- another alternative: CREATE VIEW
SELECT district_id, MAX(trans_count) AS max_trans_count
FROM trans_per_district
GROUP BY district_id;

SELECT t.account_id, t.district_id, t.trans_count
FROM trans_per_district t
JOIN max_trans_per_district m
ON t.district_id = m.district_id AND t.trans_count = m.max_trans_count
ORDER BY t.district_id;

-- ==================================================
-- Views
-- ==================================================

-- Views are like virtual tables in the database that can be used for querying just like a regular table 
-- but they do not store any information permanently in them like a table does;
-- a table occupies actual memory in the database but views don't. 
-- Views can be built with queries on single or multiple tables.

-- Creating a view to identify potential risky customers based on their balances.
-- Here, we're considering loans with status 'C' and comparing their balances with the average balance of the same status.

CREATE VIEW running_contract_ok_balances AS
WITH cte_running_contract_OK_balances AS (
  SELECT *, amount-payments AS Balance
  FROM bank.loan
  WHERE status = 'C'
  ORDER BY Balance
)
SELECT * FROM cte_running_contract_OK_balances
WHERE Balance < (
  SELECT AVG(Balance)
  FROM cte_running_contract_OK_balances
)
ORDER BY Balance DESC
LIMIT 20;
SELECT * FROM running_contract_OK_balances;

-- ==================================================
-- CHECK FOR UNDERSTANDING
-- ==================================================

-- create a view last_week_withdrawals with total withdrawals by a client in the last week.
-- Last date was 981231 - 981224

CREATE VIEW last_week_withdrawals AS
SELECT 
count(trans_id) total_withdrawals, 
account_id
FROM trans
WHERE type = 'VYDAJ' 
AND operation IN ('VYBER KARTOU', 'VYBER')
AND date BETWEEN 981224 AND 981231
group by account_id;

select * from last_week_withdrawals;