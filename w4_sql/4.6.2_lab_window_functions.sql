USE sakila;

-- 1. Rank films by length within the rating category. Output: title, length, rating and rank columns only. Filter out any rows with null or zero values in the length column.
SELECT title, length, rating,
RANK() OVER(PARTITION BY rating ORDER BY length) AS ranks
FROM film
WHERE length IS NOT NULL AND length <> 0;

-- 2. Produce a list that shows for each film, the actor who has acted in the greatest number of films, as well as the total number of films in which they have acted.

WITH actor_film_count AS (
-- Step 1: Calculate how many total films each actor has appeared in
SELECT fa.actor_id, COUNT(*) AS total_films
FROM film_actor fa
GROUP BY fa.actor_id
),
film_actor_ranked AS (
-- Step 2: For each film, join actor_film_count to get the total films per actor and rank them within each film
SELECT f.title, a.first_name, a.last_name, afc.total_films,
ROW_NUMBER() OVER (PARTITION BY f.title ORDER BY afc.total_films DESC) AS rn
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN actor_film_count afc ON fa.actor_id = afc.actor_id
)
-- Step 3: Select the actor with the most films for each film
SELECT title, CONCAT(first_name, ' ', last_name) AS actor, total_films
FROM film_actor_ranked
WHERE rn = 1;

-- 3. Retrieve the number of distinct customers who rented a movie in each month.

WITH customer_monthly_activity AS (
-- Step 1: Extract year, month, and partition by customer_id, rental_year, rental_month to mark unique rentals
SELECT 
customer_id,
YEAR(rental_date) AS rental_year,
MONTH(rental_date) AS rental_month,
ROW_NUMBER() OVER (PARTITION BY customer_id, YEAR(rental_date), MONTH(rental_date)) AS rn
FROM rental
)
-- Step 2: Count distinct customers by filtering for the first occurrence of each customer in each month
SELECT 
rental_year,
rental_month,
COUNT(customer_id) AS monthly_active_customers
FROM customer_monthly_activity
WHERE rn = 1
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;

-- 3. alternative solution, without window function
SELECT
YEAR(rental_date) AS rental_year,
MONTH(rental_date) AS rental_month,
COUNT(DISTINCT customer_id) AS monthly_active_customers
FROM rental
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;

-- 4. Get the number of active users in the previous month. Calculate the % change month-on-month.

WITH monthly_active_users AS (
-- Step 1: Count the distinct users per month
SELECT 
YEAR(rental_date) AS rental_year,
MONTH(rental_date) AS rental_month,
COUNT(DISTINCT customer_id) AS active_users
FROM rental
GROUP BY rental_year, rental_month
),
previous_month AS(
-- Step 2: Use LAG to get the number of active users from the previous month
SELECT 
rental_year,
rental_month,
active_users,
LAG(active_users) OVER (ORDER BY rental_year, rental_month) AS active_users_previous_month
FROM monthly_active_users)
-- Step 3: Month-on-month difference in active users
SELECT 
rental_year,
rental_month,
active_users,
active_users_previous_month,
FORMAT((active_users - active_users_previous_month)/active_users_previous_month*100, 2) AS percent_change
FROM previous_month
ORDER BY rental_year, rental_month;

-- 5. Calculate the number of retained customers each month, those who rented movies this and previous months.

WITH customer_monthly_rentals AS (
-- Step 1: Get distinct customers per month
SELECT 
customer_id,
YEAR(r.rental_date) AS rental_year,
MONTH(r.rental_date) AS rental_month
FROM rental r
GROUP BY customer_id, rental_year, rental_month
),
customer_retention AS (
-- Step 2: Use LAG to check if the customer rented in the previous month
SELECT 
customer_id,
rental_year,
rental_month,
LAG(rental_month, 1) OVER (PARTITION BY customer_id ORDER BY rental_year, rental_month) AS previous_rental_month,
LAG(rental_year, 1) OVER (PARTITION BY customer_id ORDER BY rental_year, rental_month) AS previous_rental_year
FROM customer_monthly_rentals
)
-- Step 3: Filter customers who rented in both the current and previous month
SELECT 
rental_year,
rental_month,
COUNT(DISTINCT customer_id) AS retained_customers
FROM customer_retention
WHERE (rental_year = previous_rental_year AND rental_month = previous_rental_month + 1)
OR (rental_year = previous_rental_year + 1 AND previous_rental_month = 12 AND rental_month = 1)
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;