#Bigquery Authentication needed to perform the operations

Objectives
In this lab, you learn about the following:

Loading semi-structured JSON into BigQuery

Creating and querying arrays

Creating and querying structs

Querying nested and repeated fields

-----------------------------------------------------------------------------------------------

#simple array creation
#standardSQL
SELECT
['raspberry', 'blackberry', 'strawberry', 'cherry'] AS fruit_array

#understanding array
#standardSQL
SELECT
['raspberry', 'blackberry', 'strawberry', 'cherry', 1234567] AS fruit_array


#standardSQL
SELECT person, fruit_array, total_cost FROM `data-to-insights.advanced.fruit_store`;



------------------------------------------------------------------------------------------------

Loading semi-structured JSON into BigQuery

Create a new table in the fruit_store data set.

Add the following details for the table:

Source: Choose Google Cloud Storage in the Create table from dropdown.

Select file from GCS bucket: gs://data-insights-course/labs/optimizing-for-performance/shopping_cart.json File format: JSON (Newline delimited)

Schema: Check Auto detect (Schema and input parameters).

Call the new table "fruit_details".

Click Create table.

In the schema, note that fruit_array is marked as REPEATED which means it''s an array

-----------------------------------------------------------------------------------------------

#Creating your own arrays with ARRAY_AGG()

SELECT
  fullVisitorId,
  date,
  v2ProductName,
  pageTitle
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
ORDER BY date

------------------------------------------------------------------------------------------------
#improve the result
#array aggregating over product name and pagetitle to reduce join and space 
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) product_viewed,
  ARRAY_AGG(pageTitle) pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
group by fullVisitorId,date
ORDER BY date

------------------------------------------------------------------------------------------------

#ARRAY_LENGTH
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(v2ProductName)) AS num_products_viewed,
  ARRAY_AGG(pageTitle) AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(pageTitle)) AS num_pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date

----------------------------------------------------------------------------------------------

#deduplication

SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(DISTINCT v2ProductName) AS products_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT v2ProductName)) AS distinct_products_viewed,
  ARRAY_AGG(DISTINCT pageTitle) AS pages_viewed,
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT pageTitle)) AS distinct_pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date


----------------------------------------------------------------------------------------------


#query of complex dataset had array

SELECT
  *
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
WHERE visitId = 1501570398

#visit and page name query

SELECT
  visitId,
  hits.page.pageTitle
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
WHERE visitId = 1501570398

#an error will be thrown
-----------------------------------------------------------------------------------------------
#unnest on array

SELECT DISTINCT
  visitId,
  h.page.pageTitle
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
UNNEST(hits) AS h
WHERE visitId = 1501570398
LIMIT 10


-------------------------------------------------------------------------------------------------

#query a struct datafield

SELECT
  visitId,
  totals.*,
  device.*
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
WHERE visitId = 1501570398
LIMIT 10

------------------------------------------------------------------------------------------------

#creating a struct


#standardSQL
SELECT STRUCT("Rudisha" as name, 23.4 as split) as runner


-----------------------------------------------------------------------------------------------


#struct and array

#standardSQL
SELECT STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits) AS runner


-----------------------------------------------------------------------------------------------

Practice ingesting JSON data
Create a new dataset titled racing.

Create a new table titled race_results.

Ingest this Google Cloud Storage JSON file:

gs://data-insights-course/labs/optimizing-for-performance/race_results.json
Source: Google Cloud Storage under Create table from dropdown.

Select file from GCS bucket: gs://data-insights-course/labs/optimizing-for-performance/race_results.json

File format: JSON (Newline delimited)

Edit Schema then move the Edit as text slider and add the following:

[
    {
        "name": "race",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "participants",
        "type": "RECORD",
        "mode": "REPEATED",
        "fields": [
            {
                "name": "name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "splits",
                "type": "FLOAT",
                "mode": "REPEATED"
            }
        ]
    }
]
Click Create table.

After the load job is successful, preview the schema for the newly created table:

----------------------------------------------------------------------------------------
#Write a query to COUNT how many racers were there in total.
#standardSQL
SELECT COUNT(p.name) AS racer_count
FROM racing.race_results AS r, UNNEST(r.participants) AS p


----------------------------------------------------------------------------------------

#Write a query that will list the total race time for racers whose names begin with R.
# Order the results with the fastest total time first.

#standardSQL
SELECT
  p.name,
  SUM(split_times) as total_race_time
FROM racing.race_results AS r
, UNNEST(r.participants) AS p
, UNNEST(p.splits) AS split_times
WHERE p.name LIKE 'R%'
GROUP BY p.name
ORDER BY total_race_time ASC;

---------------------------------------------------------------------------------------
You happened to see that the fastest lap time recorded for the 800 M race was 23.2 seconds,
 but you did not see which runner ran that particular lap. Create a query that returns that result.
#standardSQL
SELECT
  p.name,
  split_time
FROM racing.race_results AS r
, UNNEST(r.participants) AS p
, UNNEST(p.splits) AS split_time
WHERE split_time = 23.2;


-----------------------------------------------------------------------------------------
#some array functions
SELECT GENERATE_ARRAY(11, 33, 2) AS odds;

SELECT
  GENERATE_DATE_ARRAY('2017-11-21', '2017-12-31', INTERVAL 1 WEEK)
    AS date_array;

WITH sequences AS
  (SELECT [0, 1, 1, 2, 3, 5] AS some_numbers
   UNION ALL SELECT [2, 4, 8, 16, 32] AS some_numbers
   UNION ALL SELECT [5, 10] AS some_numbers)
SELECT some_numbers,
       some_numbers[OFFSET(1)] AS offset_1,
       some_numbers[ORDINAL(1)] AS ordinal_1
FROM sequences;

------------------------------------------------------------------------------------------

SELECT *
FROM UNNEST(['foo', 'bar', 'baz', 'qux', 'corge', 'garply', 'waldo', 'fred'])
  AS element
WITH OFFSET AS offset
ORDER BY offset;

+----------+--------+
| element  | offset |
+----------+--------+
| foo      | 0      |
| bar      | 1      |
| baz      | 2      |
| qux      | 3      |
| corge    | 4      |
| garply   | 5      |
| waldo    | 6      |
| fred     | 7      |
+----------+--------+


------------------------------------------------------------------------------------------

WITH races AS (
  SELECT "800M" AS race,
    [STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits),
     STRUCT("Makhloufi" as name, [24.5, 25.4, 26.6, 26.1] as splits),
     STRUCT("Murphy" as name, [23.9, 26.0, 27.0, 26.0] as splits),
     STRUCT("Bosse" as name, [23.6, 26.2, 26.5, 27.1] as splits),
     STRUCT("Rotich" as name, [24.7, 25.6, 26.9, 26.4] as splits),
     STRUCT("Lewandowski" as name, [25.0, 25.7, 26.3, 27.2] as splits),
     STRUCT("Kipketer" as name, [23.2, 26.1, 27.3, 29.4] as splits),
     STRUCT("Berian" as name, [23.7, 26.1, 27.0, 29.3] as splits)]
       AS participants)
SELECT
  race,
  participant
FROM races r
CROSS JOIN UNNEST(r.participants) as participant;


-------------------------------------------------------------------------------------------

#fastest racers

SELECT
  race,
  (SELECT name
   FROM UNNEST(participants)
   ORDER BY (
     SELECT SUM(duration)
     FROM UNNEST(splits) AS duration) ASC
   LIMIT 1) AS fastest_racer
FROM races;


-------------------------------------------------------------------------------------------
#finish time of each 

SELECT
  name, sum(duration) AS finish_time
FROM races, races.participants LEFT JOIN participants.splits duration
GROUP BY name;


------------------------------------------------------------------------------------------
#filter array
WITH sequences AS
  (SELECT [0, 1, 1, 2, 3, 5] AS some_numbers
   UNION ALL SELECT [2, 4, 8, 16, 32] AS some_numbers
   UNION ALL SELECT [5, 10] AS some_numbers)
SELECT
  ARRAY(SELECT x * 2
        FROM UNNEST(some_numbers) AS x
        WHERE x < 5) AS doubled_less_than_five
FROM sequences;

------------------------------------------------------------------------------------------
#array to STRING
WITH greetings AS
  (SELECT ["Hello", "World"] AS greeting)
SELECT ARRAY_TO_STRING(greeting, " ") AS greetings
FROM greetings;

------------------------------------------------------------------------------------------

SELECT ARRAY_CONCAT([1, 2], [3, 4], [5, 6]) as count_to_six;

+--------------------------------------------------+
| count_to_six                                     |
+--------------------------------------------------+
| [1, 2, 3, 4, 5, 6]                               |
+--------------------------------------------------+


-------------------------------------------------------------------------------------------


























































































