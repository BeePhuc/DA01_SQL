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
FROM cte;
---ex6
---solution1
WITH cte AS
(SELECT merchant_id, transaction_timestamp,
LAG(transaction_timestamp) OVER (PARTITION BY merchant_id,credit_card_id,amount
ORDER BY transaction_timestamp) AS previous_transaction_timestamp
FROM transactions),
cte_1 AS
(SELECT *,
EXTRACT (EPOCH FROM (transaction_timestamp - previous_transaction_timestamp))/60 AS diff
FROM cte)

SELECT COUNT (*) FROM cte_1
WHERE diff <= 10;
---solution2
WITH cte AS
(SELECT *,
LAG(transaction_timestamp) OVER (PARTITION BY merchant_id,credit_card_id,amount 
ORDER BY transaction_timestamp) AS previous_transaction_timestamp
FROM transactions)

SELECT COUNT (*) FROM transactions a
JOIN cte b ON a.transaction_id=b.transaction_id
WHERE a.merchant_id=b.merchant_id AND
      a.credit_card_id=b.credit_card_id AND
      a.amount=b.amount AND
      EXTRACT (EPOCH FROM (a.transaction_timestamp - previous_transaction_timestamp))/60 <= 10;
---ex7
SELECT category, product, total_spend
FROM 
(SELECT category, product, SUM (spend) AS total_spend,
RANK () OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT (year FROM transaction_date) ='2022'
GROUP BY category, product) AS a
WHERE ranking <= 2;
---ex8
WITH top10 AS 
(SELECT artist_name,
DENSE_RANK() OVER (ORDER BY COUNT(b.song_id) DESC) AS artist_rank
FROM artists a
JOIN songs b ON a.artist_id = b.artist_id
JOIN global_song_rank c ON b.song_id = c.song_id
WHERE rank <= 10
GROUP BY artist_name)

SELECT artist_name, artist_rank
FROM top10
WHERE artist_rank <= 5;
