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
SELECT COUNT(*) FROM company_cte;
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
