---ex 1
---solution 1
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) 
FROM COUNTRY
INNER JOIN CITY ON CITY.CountryCode = COUNTRY.Code
WHERE CITY.Population IS NOT NULL
GROUP BY COUNTRY.Continent;
---solution 2
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) 
FROM COUNTRY, CITY
WHERE CITY.CountryCode = COUNTRY.Code
AND CITY.Population IS NOT NULL
GROUP BY COUNTRY.Continent;
--- ex 2
SELECT ROUND(CAST(COUNT(texts.email_id)AS DECIMAL)
      /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
---ex 3
SELECT b.age_bucket, 
       ROUND (100.0*SUM (CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END)
       / (SUM (CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) + SUM (CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END)),2) AS send_percentage,
       ROUND (100.0*SUM (CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END)
       / (SUM (CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) + SUM (CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END)),2) AS send_percentage
FROM activities AS a
INNER JOIN age_breakdown AS b
ON a.user_id=b.user_id
GROUP BY b.age_bucket;
---ex 4
SELECT a.customer_id
FROM customer_contracts AS a
LEFT JOIN products AS b
ON a.product_id = b.product_id
GROUP BY a.customer_id
HAVING COUNT (DISTINCT b.product_category) = (SELECT COUNT (DISTINCT product_category) FROM products);
---ex 5
SELECT a.employee_id, a.name, COUNT(b.reports_to) AS reports_count, ROUND(AVG (b.age)) AS average_age
FROM Employees AS a
INNER JOIN Employees AS b 
ON a.employee_id=b.reports_to
GROUP BY a.employee_id;
--- ex 6
SELECT a.product_name, SUM(b.unit) AS unit
FROM Products AS a
INNER JOIN Orders AS b
ON a.product_id=b.product_id
WHERE EXTRACT(MONTH FROM b.order_date) = 02 AND EXTRACT(YEAR FROM b.order_date) = 2020
GROUP BY a.product_id
HAVING SUM(b.unit) >= 100;
---ex 7
SELECT a.page_id from pages AS a
LEFT JOIN page_likes AS b
ON a.page_id = b.page_id 
where b.page_id is NULL 
ORDER BY a.page_id;
--- Mid-course text
--- Questions 1
---task
SELECT DISTINCT replacement_cost FROM film
---question
SELECT DISTINCT replacement_cost FROM film
ORDER BY replacement_cost;
LIMIT 1
--- Question 2
---task
---solution 1
SELECT SUM (CASE WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 1 ELSE 0 END) AS Low,
       SUM (CASE WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 1 ELSE 0 END) AS Medium,
	     SUM (CASE WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 1 ELSE 0 END) AS High
FROM film;
---solution 2
SELECT CASE WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'Low'
            WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'Medium'
			      WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'High'
       END category,
COUNT(*) AS number
FROM film
GROUP BY category;
---Question
SELECT SUM (CASE WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 1 ELSE 0 END) AS Medium
FROM film;
--- Question 3
---task
SELECT a.title, a.length, c.name AS category_name
FROM film AS a
JOIN film_category AS b ON a.film_id=b.film_id
JOIN category AS c ON b.category_id=c.category_id
WHERE c.name IN ('Drama','Sports');
---Question
SELECT a.title, a.length, c.name AS category_name
FROM film AS a
JOIN film_category AS b ON a.film_id=b.film_id
JOIN category AS c ON b.category_id=c.category_id
WHERE c.name IN ('Drama','Sports')
ORDET BY a.length DESC
LIMIT 1;
--- Question 4
---task
SELECT DISTINCT c.name AS category_name, 
COUNT (*) AS count
FROM film AS a
JOIN film_category AS b ON a.film_id=b.film_id
JOIN category AS c ON b.category_id=c.category_id
GROUP BY c.name;
---Question
SELECT DISTINCT c.name AS category_name, 
COUNT (*) AS count
FROM film AS a
JOIN film_category AS b ON a.film_id=b.film_id
JOIN category AS c ON b.category_id=c.category_id
GROUP BY c.name
ORDER BY count DESC
LIMIT 1;
--- QUestion 5
---task
SELECT a.first_name, a.last_name, COUNT(b.film_id) AS count_film
FROM actor AS a
INNER JOIN film_actor AS b
ON a.actor_id=b.actor_id
GROUP BY a.actor_id;
---Question
SELECT a.first_name, a.last_name, COUNT(b.film_id) AS count_film
FROM actor AS a
INNER JOIN film_actor AS b
ON a.actor_id=b.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(b.film_id) DESC
LIMIT 1;
--- Question 6
---task
SELECT a.address
FROM address AS a
LEFT JOIN customer AS b
ON a.address_id=b.address_id
WHERE b.address_id IS NULL;
---Question
SELECT COUNT (a.address)
FROM address AS a
LEFT JOIN customer AS b
ON a.address_id=b.address_id
WHERE b.address_id IS NULL
--- Question 7
---task
SELECT a.city, SUM(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
GROUP BY a.city;
---Question
SELECT a.city, SUM(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
GROUP BY a.city
ORDER BY SUM(d.amount) DESC
LIMIT 1;
--- Question 8
---task
SELECT a.city||','||' '||e.country AS city_country, SUM(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
JOIN country AS e ON a.country_id=e.country_id
GROUP BY a.city, e.country;
---Question
SELECT a.city||','||' '||e.country AS city_country, SUM(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
JOIN country AS e ON a.country_id=e.country_id
GROUP BY a.city, e.country
ORDER BY SUM(d.amount) DESC
LIMIT 1;
