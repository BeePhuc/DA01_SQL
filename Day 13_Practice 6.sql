---ex1
---solution1
WITH job_count_cte AS
(SELECT company_id, COUNT (Job_id) AS job_count FROM job_listings
GROUP BY company_id, title, description)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies FROM job_count_cte
WHERE job_count > 1;
---solution2
WITH company_cte AS
(SELECT company_id FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(*) > 1)

SELECT COUNT(*) AS duplicate_companies FROM company_cte;
---ex2
SELECT category, product, total_spend
FROM 
(SELECT category, product, SUM (spend) AS total_spend,
RANK () OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT (year FROM transaction_date) ='2022'
GROUP BY category, product) AS a
WHERE ranking <= 2;
---ex3
---solution1
SELECT COUNT (policy_holder_id) AS member_count FROM
(SELECT policy_holder_id FROM callers
GROUP BY policy_holder_id
HAVING COUNT (case_id) >= 3) AS call_count;
---solution2
WITH call_count_cte AS
(SELECT CASE WHEN COUNT (case_id) >= 3
THEN 1 ELSE 0 END call_count FROM callers
GROUP BY policy_holder_id)

SELECT SUM (call_count) FROM call_count_cte;
---ex4
---solution1
SELECT a.page_id from pages AS a
LEFT JOIN page_likes AS b
ON a.page_id = b.page_id 
WHERE b.page_id is NULL;
--solution2
SELECT page_id FROM pages AS a
WHERE NOT EXISTS (SELECT page_id FROM page_likes
                  WHERE page_id = a.page_id);
ORDER BY a.page_id
---ex5
SELECT EXTRACT(MONTH FROM event_date) AS month, 
COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = 7
AND user_id IN (SELECT user_id FROM user_actions
                WHERE EXTRACT(MONTH FROM event_date) = 6)
AND EXTRACT(YEAR FROM event_date)=2022
GROUP BY month;
---ex6
WITH cte AS
(SELECT * , DATE_FORMAT(trans_date,"%Y-%m") AS month
FROM Transactions)

SELECT cte.month, cte.country,
COUNT(*) AS trans_count,
SUM(CASE WHEN cte.state = "approved" THEN 1 ELSE 0 END) AS approved_count,
SUM(cte.amount) AS trans_total_amount,
SUM(CASE WHEN cte.state = "approved" THEN amount ELSE 0 END ) as approved_total_amount
FROM cte
GROUP BY cte.month, cte.country;
---ex7
WITH first_year_product AS
(SELECT product_id AS first_year FROM Sales AS a
GROUP BY product_id
HAVING year = MIN(year))

SELECT product_id, year AS first_year, b.quantity, b.price FROM first_year_product
JOIN Sales AS b ON a.product_id=b.product_id;
---ex8
SELECT customer_id FROM Customer
GROUP BY customer_id
HAVING COUNT (DISTINCT product_key) = (SELECT COUNT (product_key) FROM Product)
---ex9
SELECT employee_id FROM Employees
WHERE manager_id NOT IN (SELECT employee_id FROM Employees AS employee)
AND salary < 30000
---ex10
---solution1
WITH job_count_cte AS
(SELECT company_id, COUNT (Job_id) AS job_count FROM job_listings
GROUP BY company_id, title, description)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies FROM job_count_cte
WHERE job_count > 1;
---solution2
WITH company_cte AS
(SELECT company_id FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(*) > 1)

SELECT COUNT(*) AS duplicate_companies FROM company_cte;
---ex11
(SELECT name AS results FROM Users AS u
JOIN MovieRating AS a ON u.user_id=a.user_id
GROUP BY name
ORDER BY COUNT(a.rating) DESC, name
LIMIT 1)

UNION

(SELECT title AS results FROM Movies AS b
JOIN MovieRating AS a ON b.movie_id=a.movie_id
WHERE DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
GROUP BY title
ORDER BY AVG(a.rating) DESC, b.title
LIMIT 1)
---ex12
WITH cte AS
(SELECT requester_id AS id FROM requestaccepted
UNION ALL
SELECT accepter_id AS id FROM requestaccepted)

SELECT id, count(id) AS num FROM cte
GROUP BY id
ORDER BY num DESC
LIMIT 1;
