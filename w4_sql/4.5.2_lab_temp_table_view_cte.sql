USE sakila;

-- Creating a Customer Summary Report
-- 1: Create a View that summarizes rental information for each customer. 
-- Contents: customer's ID, name, email address, and total number of rentals (rental_count).
DROP VIEW rental_summary;
CREATE VIEW rental_summary AS
SELECT customer_id, first_name, last_name, email, count(rental_id) AS rental_count
FROM customer
JOIN rental USING (customer_id)
GROUP BY customer_id, first_name, last_name, email;

SELECT * FROM rental_summary;

-- 2: Create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
-- Contents: task 1 VIEW, JOIN payment table, calculate the total amount paid by each customer.
DROP TEMPORARY TABLE temp_total_amount_paid;
CREATE TEMPORARY TABLE temp_total_amount_paid AS
SELECT customer_id, SUM(amount) AS total_amount_paid
FROM rental_summary
JOIN payment USING (customer_id)
GROUP BY customer_id;

SELECT * FROM temp_total_amount_paid;

-- 3: Create a CTE FROM task 1 VIEW, task 2 TEMPORARY TABLE
-- Contents: customer name, email, rental_count, total_paid and average_payment_per_rental. 
-- the last column is a derived column from total_paid and rental_count.
-- using the CTE, create the query to generate final customer summary report. 
WITH customer_summary_report AS(
SELECT 
r.customer_id, 
r.first_name, 
r.last_name, 
r.email, 
r.rental_count, 
t.total_amount_paid
FROM rental_summary AS r
JOIN temp_total_amount_paid AS t USING (customer_id)
)
-- Create the query to generate the customer summary report.
SELECT *, total_amount_paid / rental_count AS avg_payment_per_rental
FROM customer_summary_report;