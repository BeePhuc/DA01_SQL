--- ex1
SELECT DISTINCT CITY FROM STATION
WHERE ID%2 = 0;
--- ex2
SELECT COUNT(CITY) - COUNT (DISTINCT (CITY)) FROM STATION;
--- ex3
SELECT CEIL(AVG(salary)-AVG(REPLACE(salary,0,''))) FROM EMPLOYEES;
--- ex4
SELECT 
ROUND(CAST (SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL),1)
FROM items_per_order;
--- ex5
SELECT DISTINCT candidate_id FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT (skill) = 3
ORDER BY candidate_id;
--- ex6
SELECT user_id, 
DATE(MAX (post_date)) - DATE(MIN (post_date))
FROM posts
WHERE post_date BETWEEN '2021-01-01' AND '2022-01-01'
GROUP BY user_id
HAVING COUNT (*) >= 2;
--- ex7
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY MAX(issued_amount) - MIN(issued_amount) DESC;
--- ex8
SELECT manufacturer, 
COUNT (*) AS drug_count,
ABS(SUM(cogs - total_sales)) AS total_loss 
FROM pharmacy_sales
WHERE cogs - total_sales > 0
GROUP BY manufacturer
ORDER BY ABS(SUM(cogs - total_sales)) DESC;
--- ex9
SELECT * FROM Cinema
WHERE id%2 <> 0 AND description <> 'boring'
ORDER BY rating DESC;
--- ex10
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt FROM Teacher
GROUP BY teacher_id;
--- ex11
SELECT user_id, COUNT(user_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id;
--- ex12
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
