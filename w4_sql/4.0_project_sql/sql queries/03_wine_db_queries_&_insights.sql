-- Setting the working database
USE wine;

-- ==================================================
-- BASIC QUERIES

-- ==================================================
-- Selecting all the data from each table, to check if the data succesfully loaded from the .csv files
SHOW TABLES;
SELECT * FROM red;
SELECT * FROM rose;
SELECT * FROM sparkling;
SELECT * FROM white;

-- ===================================================================
-- Counting the number of records per table
SELECT 'red' AS table_name, COUNT(*) AS record_count FROM red
UNION ALL
SELECT 'rose' AS table_name, COUNT(*) AS record_count FROM rose
UNION ALL
SELECT 'sparkling' AS table_name, COUNT(*) AS record_count FROM sparkling
UNION ALL
SELECT 'white' AS table_name, COUNT(*) AS record_count FROM white;

-- ===================================================================
-- Getting unique values of a column, to gain insights about the wines

-- ===================================================================
-- COUNTRIES

-- ===================================================================
-- How many countries do the wines come from
SELECT COUNT(DISTINCT country) FROM red; -- 30 countries
SELECT COUNT(DISTINCT country) FROM rose; -- 16
SELECT COUNT(DISTINCT country) FROM sparkling; -- 16
SELECT COUNT(DISTINCT country) FROM white; -- 30

-- ===================================================================
-- What countries most of the wines come from
SELECT country, COUNT(country) FROM red
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 5; -- Top 5: Italy, France, Spain, South Africa, United States

SELECT country, COUNT(country) FROM rose
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 5; -- Top 5: France, Italy, Spain, South Africa, Germany

SELECT country, COUNT(country) FROM sparkling
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 5; -- Top 5: France, Italy, Germany, Spain, South Africa

SELECT country, COUNT(country) FROM white
GROUP BY country
ORDER BY COUNT(country) DESC
LIMIT 5; -- Top 5: Germany, Italy, France, South Africa, Spain

-- ===================================================================
-- REGIONS
-- ===================================================================

-- How many countries do the wines come from
SELECT COUNT(DISTINCT region) FROM red; -- 624 regions
SELECT COUNT(DISTINCT region) FROM rose; -- 129
SELECT COUNT(DISTINCT region) FROM sparkling; -- 123
SELECT COUNT(DISTINCT region) FROM white; -- 457

-- ===================================================================
-- RATINGS: What countries offer the best rating-price ratio
-- ===================================================================

-- ===================================================================
-- RED WINE

-- Top 5 HIGHEST-RATED RED wine producers: 7, Lebanon, Georgia, Croatia, United States
SELECT country, ROUND(AVG(rating),2) FROM red
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Moldova','4.16'
'Lebanon','4.16'
'Georgia','4.14'
'Croatia','4.1'
'United States','3.95'
*/

-- Top 5 MOST AFFORDABLE RED wine producers: Mexico, Bulgaria, Slovenia, Uruguay, Romania 
SELECT country, ROUND(AVG(price),2) FROM red
GROUP BY country
ORDER BY AVG(price)
LIMIT 5;
/*
'Mexico','8.65'
'Bulgaria','10.15'
'Slovenia','11.9'
'Uruguay','14.39'
'Romania','14.5'
*/

-- The average ratings for the top 5 most affordable RED wine producers
SELECT country, ROUND(AVG(rating), 2) AS avg_rating
FROM red
WHERE country IN ('Mexico', 'Bulgaria', 'Slovenia', 'Uruguay', 'Romania')
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Uruguay','3.82'
'Bulgaria','3.8'
'Romania','3.76'
'Slovenia','3.54'
'Mexico','3.4'
*/

-- ===================================================================
-- ROSE WINE

-- Top 5 HIGHEST-RATED ROSE wine producers: Moldova, Greece, France, Austria, New Zealand
SELECT country, ROUND(AVG(rating),2) FROM rose
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Moldova','4.2'
'Greece','4'
'France','3.87'
'Austria','3.81'
'New Zealand','3.8'
*/

-- Top 5 MOST AFFORDABLE ROSE wine producers: Portugal, South Africa, Chile, Spain, Argentina 
SELECT country, ROUND(AVG(price),2) FROM rose
GROUP BY country
ORDER BY AVG(price)
LIMIT 5;
/*
'Portugal','8.11'
'South Africa','8.16'
'Chile','8.91'
'Spain','8.92'
'Argentina','9.2'
*/

-- The average ratings for the top 5 most affordable ROSE wine producers
SELECT country, ROUND(AVG(rating), 2) AS avg_rating
FROM rose
WHERE country IN ('Portugal', 'South Africa', 'Chile', 'Spain', 'Argentina')
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Argentina','3.7'
'Portugal','3.64'
'South Africa','3.62'
'Spain','3.6'
'Chile','3.6'
*/

-- ===================================================================
-- SPARKLING WINE

-- Top 5 HIGHEST-RATED SPARKLING wine producers: Moldova, United Kingdom, France, New Zealand, United States
SELECT country, ROUND(AVG(rating),2) FROM sparkling
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Moldova','4.25'
'United Kingdom','4.03'
'France','4.03'
'New Zealand','4'
'United States','3.9'
*/

-- Top 5 MOST AFFORDABLE SPARKLING wine producers: Slovenia, Brazil, Spain, New Zealand, Portugal 
SELECT country, ROUND(AVG(price),2) FROM sparkling
GROUP BY country
ORDER BY AVG(price)
LIMIT 5;
/*
'Slovenia','14.08'
'Brazil','14.24'
'Spain','14.66'
'New Zealand','15.22'
'Portugal','17.97'
*/

-- The average ratings for the top 5 most affordable SPARKLING wine producers
SELECT country, ROUND(AVG(rating), 2) AS avg_rating
FROM sparkling
WHERE country IN ('Slovenia', 'Brazil', 'Spain', 'New Zealand', 'Portugal')
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'New Zealand','4'
'Brazil','3.87'
'Portugal','3.77'
'Slovenia','3.7'
'Spain','3.7'
*/

-- ===================================================================
-- WHITE WINE

-- Top 5 HIGHEST-RATED WHITE wine producers: Moldova, Croatia, Czech Republic, New Zealand, Germany
SELECT country, ROUND(AVG(rating),2) FROM white
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Moldova','4.1'
'Croatia','4.08'
'Czech Republic','4.05'
'New Zealand','3.9'
'Germany','3.9'
*/

-- Top 5 MOST AFFORDABLE WHITE wine producers: Romania, Brazil, Moldova, Chile, Turkey 
SELECT country, ROUND(AVG(price),2) FROM white
GROUP BY country
ORDER BY AVG(price)
LIMIT 5;
/*
'Romania','9.86'
'Brazil','10.82'
'Moldova','10.98'
'Chile','11.9'
'Turkey','12'
*/

-- The average ratings for the top 5 most affordable WHITE wine producers
SELECT country, ROUND(AVG(rating), 2) AS avg_rating
FROM white
WHERE country IN ('Romania', 'Brazil', 'Moldova', 'Chile', 'Turkey')
GROUP BY country
ORDER BY AVG(rating) DESC
LIMIT 5;
/*
'Moldova','4.1'
'Romania','3.68'
'Chile','3.58'
'Turkey','3.35'
'Brazil','3.32'
*/

-- ===================================================================
-- OVERALL

-- Top 5 HIGHEST-RATED wine producers: Moldova, Lebanon, Croatia, Czech Republic, United Kingdom

SELECT country, ROUND(AVG(avg_rating),2) AS overall_avg_rating
FROM (
    SELECT country, AVG(rating) AS avg_rating
    FROM (
        SELECT country, rating FROM red
        UNION ALL
        SELECT country, rating FROM rose
        UNION ALL
        SELECT country, rating FROM sparkling
        UNION ALL
        SELECT country, rating FROM white
    ) AS all_wines
    GROUP BY country
) AS overall_ratings
GROUP BY country
ORDER BY overall_avg_rating DESC
LIMIT 5;
/*
'Moldova','4.18'
'Lebanon','4.14'
'Croatia','4.08'
'Czech Republic','4.05'
'United Kingdom','4.03'
*/

-- Top 5 MOST AFFORDABLE wine producers: Mexico, Bulgaria, Romania, Slovenia, Hungary

SELECT country, ROUND(AVG(avg_price),2) AS overall_avg_price
FROM (
    SELECT country, AVG(price) AS avg_price
    FROM (
        SELECT country, price FROM red
        UNION ALL
        SELECT country, price FROM rose
        UNION ALL
        SELECT country, price FROM sparkling
        UNION ALL
        SELECT country, price FROM white
    ) AS all_wines
    GROUP BY country
) AS overall_price
GROUP BY country
ORDER BY overall_avg_price
LIMIT 5;
/*
'Mexico','8.65'
'Bulgaria','10.15'
'Romania','12.82'
'Slovenia','13.05'
'Hungary','13.37'
*/

-- =====================================================================
-- The most affordable wines from the producers with the highest ratings
-- =====================================================================

-- =====================================================================
-- The average price for ROSE: Moldova, Greece, Austria

SELECT country, ROUND(AVG(price), 2) AS avg_price
FROM rose
WHERE country IN ('Moldova', 'Greece', 'Austria')
GROUP BY country
ORDER BY AVG(price);
/*
'Austria','10.73'
'Moldova','10.98'
'Greece','11.5'
*/

-- ===================================================================
-- The average price for RED: Moldova, Lebanon, Georgia, Croatia

SELECT country, ROUND(AVG(price), 2) AS avg_price
FROM red
WHERE country IN ('Moldova', 'Lebanon', 'Georgia', "Croatia")
GROUP BY country
ORDER BY AVG(price);
/*
'Croatia','21.4'
'Georgia','21.53'
'Moldova','28.85'
'Lebanon','37.21'
*/

-- ===================================================================
-- The average price for SPARKLING: Moldova, United Kingdom

SELECT country, ROUND(AVG(price), 2) AS avg_price
FROM sparkling
WHERE country IN ('Moldova', 'United Kingdom')
GROUP BY country
ORDER BY AVG(price);
/*
'Moldova','27.42'
'United Kingdom','57.77'
*/

-- ===================================================================

-- The average price for WHITE: Moldova, Croatia, Czech Republic, Germany
SELECT country, ROUND(AVG(price), 2) AS avg_price
FROM white
WHERE country IN ('Moldova', 'Croatia', 'Czech Republic', 'Germany')
GROUP BY country
ORDER BY AVG(price);
/*
'Moldova','10.98'
'Croatia','22.25'
'Germany','22.33'
'Czech Republic','25.4'
*/