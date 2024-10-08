-- ==================================================
-- SETTING UP THE DATABASE
-- ==================================================

-- Setting the working database
USE bank;

-- ==================================================
-- WINDOW FUNCTIONS
-- ==================================================

-- A window function is a way to perform computations across a set of rows related to the current row.
-- Let's start with a simple aggregation function to see its difference from window functions.
-- Getting the average loan amount for comparison purposes will return a single value:
SELECT AVG(amount) AS 'Avg_amount' FROM bank.loan;

-- With a window function, we can have both the table and aggregation.
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER() AS 'Avg_amount'
FROM bank.loan;

-- Now, we may want to compute the AVG by `status` to compare every loan amount against the AVG by status.
-- To do this, we can add a `partition by` inside the `over()`
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER(PARTITION BY status) AS 'Avg_amount'
FROM bank.loan;

-- We can add another sublevel of partition. For example duration.
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER(PARTITION BY status, duration) AS 'Avg_amount'
FROM bank.loan;

-- We can order the results by status, duration, and amount
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER(PARTITION BY status, duration) AS 'Avg_amount'
FROM bank.loan
ORDER BY status, duration, amount DESC;

-- When used with non-aggregating window functions, ORDER BY just sorts the rows.
-- With aggregations, ORDER BY within OVER() doesn't sort rows but changes aggregations to cumulative.
-- In the ongoing example:
-- Without ORDER BY, the window function calculates the AVG per partition.
-- With ORDER BY used, it calculates cumulative AVG per row.
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER(PARTITION BY status, duration ORDER BY status, duration, amount DESC) AS 'Avg_amount'
FROM bank.loan;

-- Multiple window functions in a single query are possible.
-- Let's add ROW_NUMBER to assign a unique sequential integer to rows within a partition of a result set.
SELECT 
status, loan_id, duration, amount,
AVG(amount) OVER(PARTITION BY status, duration) AS 'Avg_amount',
ROW_NUMBER() OVER(PARTITION BY status, duration ORDER BY status, duration, amount DESC) AS 'Row_number'
FROM bank.loan
ORDER BY status, duration, amount DESC;

-- ==================================================
-- MORE ON WINDOW FUNCTIONS - RANK, DENSE_RANK, ROW_NUMBER
-- ==================================================

-- RANK assigns a unique rank within the result set, with the same rank assigned to rows with the same values.
-- In the event of ties, subsequent rank numbers are skipped. 
-- Example, if two rows tie for rank 3, the next row will be ranked 5. Demo: 1,2,3,3,5
-- DENSE_RANK also assigns rank like RANK but does not skip any rank in case of tie. Demo: 1,2,3,3,4
-- ROW_NUMBER, on the other hand, assigns a unique sequential integer to rows within a partition of a result set.

-- Getting the rank of loans based on the amount:
SELECT *, RANK() OVER(ORDER BY amount DESC) AS 'Rank'
FROM bank.loan;
-- Note the absence of partition clause, thus no "windows". It's just data ranking.

-- Achieving the same result with ROW_NUMBER
SELECT *, ROW_NUMBER() OVER(ORDER BY amount DESC) AS 'Row Number'
FROM bank.loan;

-- Let's rank the customers based on the amount, in each of the "k_symbol" categories
SELECT * , RANK() OVER(PARTITION BY k_symbol ORDER BY amount DESC) AS "Ranks"
FROM bank.order
WHERE k_symbol <> " ";

-- You can use subqueries to filter the ranks. Examples: top 10 customers, or find the n-th highest customer.

-- ==================================================
-- BONUS: CHECK FOR UNDERSTANDING
-- ==================================================

-- From `district` table, use the following columns:
-- - A4: no. of inhabitants
-- - A9: no. of cities
-- - A10: the ratio of urban inhabitants
-- - A11: average salary
-- - A12: the unemployment rate

-- 1. Rank districts by different variables.

-- I'm doing rankings OVER(the columns above). All the rankings are in DESC order.
SELECT *, RANK() OVER(ORDER BY A4 DESC) AS ranks FROM district; -- ranked from the most inhabitated down
SELECT *, RANK() OVER(ORDER BY A9 DESC) AS ranks FROM district; -- by number of cities per region
SELECT *, RANK() OVER(ORDER BY A10 DESC) AS ranks FROM district; -- ratio of urban inhabitants
SELECT *, RANK() OVER(ORDER BY A11 DESC) AS ranks FROM district; -- AVG salary
SELECT *, RANK() OVER(ORDER BY A12 DESC) AS ranks FROM district; -- unemployment

-- 2. Do the same but group by `region`.
SELECT *, RANK() OVER(PARTITION BY A9 ORDER BY A4 DESC) AS ranks FROM district;
SELECT *, RANK() OVER(PARTITION BY A10 ORDER BY A4 DESC) AS ranks FROM district;
SELECT *, RANK() OVER(PARTITION BY A11 ORDER BY A4 DESC) AS ranks FROM district;
SELECT *, RANK() OVER(PARTITION BY A12 ORDER BY A4 DESC) AS ranks FROM district;


-- ==================================================
-- BONUS: WINDOW FUNCTIONS - LAG FUNCTION
-- ==================================================
-- LAG is a window function that provides access to more than one row of a table at the same time.
-- LAG accesses data from a previous row in the same result set without the use of a self-join. 

-- Exercise: find month-on-month difference in monthly active users

-- Step 1: Get the account_id, date, year, month and month_number for every transaction.
CREATE OR REPLACE VIEW user_activity AS
SELECT account_id, 
CONVERT(date, DATE) AS Activity_date, -- because the current format is a six-digit number
DATE_FORMAT(CONVERT(date,DATE), '%M') AS Activity_Month,
DATE_FORMAT(CONVERT(date,DATE), '%m') AS Activity_Month_number,
DATE_FORMAT(CONVERT(date,DATE), '%Y') AS Activity_year
FROM bank.trans;

-- Check the results
SELECT * FROM bank.user_activity;

-- Step 2: Get count of active users by Year and Month with GROUP BY. ORDER BY year and month NUMBER.
SELECT 
Activity_year, 
Activity_Month, 
Activity_Month_number, 
COUNT(account_id) AS Active_users 
FROM bank.user_activity
GROUP BY Activity_year, Activity_Month, Activity_Month_number
ORDER BY Activity_year, Activity_Month_number;

-- Step 3: Store the results in a VIEW for later use
CREATE OR REPLACE VIEW bank.monthly_active_users AS
SELECT 
Activity_year, 
Activity_Month, 
Activity_Month_number, 
COUNT(account_id) AS Active_users 
FROM bank.user_activity
GROUP BY Activity_year, Activity_Month, Activity_Month_number
ORDER BY Activity_year ASC, Activity_Month_number ASC;

-- Check the results
SELECT * FROM monthly_active_users;

-- Step 4: Use LAG to compute difference of active_users between one month and the previous one for each year. 
-- with LAG = 1 (as we want the lag from one previous record)
SELECT 
Activity_year,
Activity_month,
Active_users,
LAG(Active_users, 1) OVER (ORDER BY Activity_year, Activity_Month_number) AS Last_month,
(Active_users - LAG(Active_users, 1) OVER (ORDER BY Activity_year, Activity_Month_number)) AS Difference
FROM monthly_active_users;

-- Step 4 alternative:
WITH cte_view AS (
SELECT 
Activity_year, 
Activity_month,
Active_users, 
LAG(Active_users,1) OVER(ORDER BY Activity_year, Activity_Month_number) AS Last_month
FROM monthly_active_users)
SELECT 
Activity_year, 
Activity_month, 
Active_users, 
Last_month, 
(Active_users - Last_month) AS Difference 
FROM cte_view;

-- FYI: LAG(Active_users, 1) = LAG(Active_users) because 1 is the default value of LAG offset