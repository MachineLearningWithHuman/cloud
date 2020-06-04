SELECT * FROM Accommodation;
SELECT * FROM Rating;
SELECT * FROM Recommendation;

--0 records return

--go to ingest.sh to ingest data into databases

--after import finish
USE recommendation_spark;

SELECT * FROM Rating
LIMIT 15;

SELECT COUNT(*) AS num_ratings
FROM Rating;

--some data analysis
SELECT
    COUNT(userId) AS num_ratings,
    COUNT(DISTINCT userId) AS distinct_user_ratings,
    MIN(rating) AS worst_rating,
    MAX(rating) AS best_rating,
    AVG(rating) AS avg_rating
FROM Rating;

--user specific
--which user provides most ratings
SELECT
    userId,
    COUNT(rating) AS num_ratings
FROM Rating
GROUP BY userId
ORDER BY num_ratings DESC;

--user specific
-- which user provides least ratings
SELECT
    userId,
    COUNT(rating) AS num_ratings
FROM Rating
GROUP BY userId
ORDER BY num_ratings;

--go to readme files
