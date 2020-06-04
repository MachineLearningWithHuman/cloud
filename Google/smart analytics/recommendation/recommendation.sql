--explore 1
SELECT
  COUNT(DISTINCT userId) numUsers,
  COUNT(DISTINCT movieId) numMovies,
  COUNT(*) totalRatings
FROM
  movies.movielens_ratings

  --138 thousand users,27 thousand movies,20 million ratings
  --use approx_distinct_count to save I/O operations

  --movies 
  SELECT
  *
FROM
  movies.movielens_movies_raw
WHERE
  movieId < 5

--clean movies dataset
  CREATE OR REPLACE TABLE
  movies.movielens_movies AS
SELECT
  * REPLACE(SPLIT(genres, "|") AS genres)
FROM
  movies.movielens_movies_raw


  --collaborative filtering
CREATE OR REPLACE MODEL
  movies.movie_recommender
OPTIONS
  (model_type='matrix_factorization',
    user_col='userId',
    item_col='movieId',
    rating_col='rating',
    l2_reg=0.2,
    num_factors=16) AS
SELECT
  userId,
  movieId,
  rating
FROM
  movies.movielens_ratings


  #model evaluation
  SELECT * FROM ML.EVALUATE(MODEL `movies.movie_recommender`)

#prediction for user id 903
SELECT
  *
FROM
  ML.PREDICT(MODEL `movies.movie_recommender`,
    (
    SELECT
      movieId,
      title,
      903 AS userId
    FROM
      `movies.movielens_movies`,
      UNNEST(genres) g
    WHERE
      g = 'Comedy' ))
ORDER BY
  predicted_rating DESC
LIMIT
  5  

  --only prediction of unseen movies is

  SELECT
  *
FROM
  ML.PREDICT(MODEL `movies.movie_recommender`,
    (
    WITH
      seen AS (
      SELECT
        ARRAY_AGG(movieId) AS movies
      FROM
        movies.movielens_ratings
      WHERE
        userId = 903 )
    SELECT
      movieId,
      title,
      903 AS userId
    FROM
      movies.movielens_movies,
      UNNEST(genres) g,
      seen
    WHERE
      g = 'Comedy'
      AND movieId NOT IN UNNEST(seen.movies) ))
ORDER BY
  predicted_rating DESC
LIMIT
  5


--batch prediction results
SELECT
  *
FROM
  ML.RECOMMEND(MODEL `cloud-training-prod-bucket.movies.movie_recommender`)
LIMIT 
  100000


  --customer tarheting
  SELECT
  *
FROM
  ML.PREDICT(MODEL `movies.movie_recommender`,
    (
    WITH
      allUsers AS (
      SELECT
        DISTINCT userId
      FROM
        movies.movielens_ratings )
    SELECT
      96481 AS movieId,
      (
      SELECT
        title
      FROM
        movies.movielens_movies
      WHERE
        movieId=96481) title,
      userId
    FROM
      allUsers ))
ORDER BY
  predicted_rating DESC
LIMIT
  100