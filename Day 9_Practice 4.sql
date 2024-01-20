--- ex1
--- Solution 1:
SELECT 
SUM (CASE
           WHEN device_type = 'laptop' THEN 1 ELSE 0
     END) AS laptop_reviews,
SUM (CASE 
           WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0
     END) AS mobile_views
FROM viewership;
--- Solution 2:
SELECT 
  (SELECT COUNT(device_type) FROM viewership 
   WHERE device_type = 'laptop')
AS laptop_views,
  (SELECT COUNT(device_type) FROM viewership 
   WHERE device_type IN ('tablet', 'phone')) 
AS mobile_views;
--- ex 2
SELECT x, y, z, 
CASE
    WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
    ELSE 'No'
END triangle
FROM Triangle;
--- ex 3
SELECT ROUND(100 * SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 ELSE 0
                       END)/ COUNT(*), 1) AS call_percentage
FROM callers;
--- ex4
SELECT name FROM Customer 
WHERE referee_id <> 2 OR referee_id IS NULL;
--- ex5
SELECT
    survived,
    SUM(CASE 
           WHEN pclass = 1 THEN 1 ELSE 0 
        END) AS first_class,
    SUM(CASE 
           WHEN pclass = 2 THEN 1 ELSE 0 
        END) AS second_class,
    SUM(CASE 
           WHEN pclass = 3 THEN 1 ELSE 0 
        END) AS third_class
FROM titanic
GROUP BY survived;
