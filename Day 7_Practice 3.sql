--- ex1
SELECT Name FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT (NAME,3), ID;
--- ex2
SELECT user_id,
CONCAT (UPPER (LEFT (name,1)), LOWER (RIGHT(name,LENGTH (name)-1))) AS name
FROM Users
ORDER BY user_id;
--- ex3
SELECT manufacturer, 
CONCAT ('$',ROUND (SUM (total_sales)/1000000,0),' ', 'million') AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY CEILING (SUM (total_sales)) DESC, manufacturer;
--- ex4
SELECT EXTRACT (month FROM submit_date), product_id,
ROUND (AVG (stars),2)
FROM reviews
GROUP BY product_id, EXTRACT (month FROM submit_date)
ORDER BY EXTRACT (month FROM submit_date), product_id;
--- ex5
SELECT sender_id, COUNT (message_id) AS message_count FROM messages
WHERE EXTRACT (month FROM sent_date) = '8' AND EXTRACT (year FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY COUNT (message_id) DESC;
LIMIT 2
--- ex6
SELECT tweet_id FROM Tweets
WHERE LENGTH (content) > 15;
--- ex7
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE DATEDIFF('2019-07-27', activity_date) < 30 
AND activity_date <= '2019-07-27' 
GROUP BY activity_date;
--- ex8
SELECT COUNT (id) FROM employees
WHERE EXTRACT (year FROM joining_date) = '2022'
AND EXTRACT (month FROM joining_date) BETWEEN 1 AND 7;
--- ex9
SELECT POSITION ('a' IN first_name) FROM worker
WHERE first_name = 'Amitah';
--- ex10
SELECT SUBSTRING (title, LENGTH (winery) + 2 , 4) AS year  from winemag_p2
WHERE country = 'Macedonia';
