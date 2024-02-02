---ex1
WITH year_cte AS
(SELECT *, EXTRACT(YEAR FROM transaction_date)  AS year 
FROM user_transactions),
cte AS
(SELECT year, product_id,
SUM(spend) OVER (PARTITION BY product_id, year) AS curr_year_spend
FROM year_cte
ORDER BY product_id, year ASC)

SELECT *, 
LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id) AS prev_year_spend,
ROUND(100*(curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id))
/LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id),2) AS yoy_rate
FROM cte;
---ex2
SELECT DISTINCT card_name, 
FIRST_VALUE(SUM(issued_amount)) OVER(PARTITION BY card_name 
ORDER BY issue_year, issue_month) AS issued_amount
FROM monthly_cards_issued
GROUP BY card_name, issue_year, issue_month
ORDER BY issued_amount DESC;
---ex3
WITH cte AS
(SELECT *,
RANK () OVER (PARTITION BY user_id ORDER BY transaction_date) AS rank
FROM transactions)

SELECT user_id, spend, transaction_date FROM cte
WHERE rank=3;
---ex4
WITH cte AS 
(SELECT transaction_date, user_id, product_id, 
RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS rank 
FROM user_transactions) 
  
SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM cte
WHERE rank = 1 
GROUP BY transaction_date, user_id
ORDER BY transaction_date;
---ex5
WITH cte AS 
(SELECT *,
COALESCE(LAG(tweet_count, 1) OVER(PARTITION BY user_id ORDER BY tweet_date),0) AS a,
COALESCE(LAG(tweet_count, 2) OVER(PARTITION BY user_id ORDER BY tweet_date),0) AS b
FROM tweets)

SELECT user_id, tweet_date,
ROUND((1.0*(tweet_count + a + b)/
(CASE WHEN a=0 AND b=0 THEN 1
      WHEN b=0 THEN 2
ELSE 3 END)), 2) AS rolling_avg_3d
FROM cte
