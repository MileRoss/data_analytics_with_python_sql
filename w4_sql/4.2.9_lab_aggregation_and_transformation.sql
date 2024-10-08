-- Challenge 1: use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT
MIN(sakila.film.length) AS min_duration,
MAX(sakila.film.length) AS max_duration
FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Look for floor and round functions.
SELECT 
SEC_TO_TIME(FLOOR(AVG(sakila.film.length)) * 60) AS avg_duration
FROM sakila.film;

-- 2. gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
DATEDIFF
(MAX(sakila.rental.rental_date),MIN(sakila.rental.rental_date))
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
*, 
MONTHNAME(sakila.rental.rental_date) AS month,
DAYNAME(sakila.rental.rental_date) AS weekday
FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT
*, 
DAYNAME(sakila.rental.rental_date) AS weekday,
CASE
WHEN DAYNAME(sakila.rental.rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM sakila.rental;

-- 3. Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT
sakila.film.title,
IFNULL(sakila.film.rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY sakila.film.title;

-- 4. Bonus: Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT
*,
CONCAT(
sakila.customer.first_name, 
sakila.customer.last_name, 
LEFT(sakila.customer.email,3)
) AS campaign
FROM sakila.customer
ORDER BY sakila.customer.last_name;

SELECT 
CONCAT(sakila.customer.first_name, ' ', sakila.customer.last_name, ' (', LEFT(sakila.customer.email, 3), '...)') AS campaign 
FROM sakila.customer 
ORDER BY sakila.customer.last_name;


-- Challenge 2: analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(sakila.film.film_id)
FROM sakila.film;

-- 1.2 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT 
sakila.film.rating,
COUNT(sakila.film.rating) AS count
FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY count DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT
sakila.film.rating,
ROUND(AVG(sakila.film.length),2) as length
FROM sakila.film
GROUP BY sakila.film.rating
ORDER BY length DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours.
SELECT
sakila.film.rating,
ROUND(AVG(sakila.film.length),2) as length
FROM sakila.film
GROUP BY sakila.film.rating
HAVING length > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT
sakila.actor.last_name
FROM sakila.actor
GROUP BY sakila.actor.last_name
HAVING COUNT(sakila.actor.last_name) = 1;