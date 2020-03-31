CREATE OR REPLACE TABLE ecommerce.partition_by_day
PARTITION BY date_formatted
OPTIONS(
descriptions="a table partition by date"
) AS

SEELCT DISTINCT
PARSE_DATE("%Y%m%d", date) AS date_formatted,
fullvisitorId
from  `data-to-insights.ecommerce.all_sessions_raw`

#standardSQL
SELECT *
FROM `data-to-insights.ecommerce.partition_by_day`
WHERE date_formatted = '2016-08-01'

--processing memory reduced drasticly

--Problem
--Queries on weather data from 2018 onward
--Filters to only include days that have had some precipitation (rain, snow, etc.)
--Only stores each partition of data for 90 days from that partition's date (rolling window)
SELECT 
DATE(CAST(year as INT64), CAST(mo as INT64), CAST(da as INT64)) AS date,
(SELECT ANY_VALUE(name) FROM `bigquery-public-data.noaa_gsod.stations` AS stations 
WHERE stations.usaf = stn) AS station_name, prcp

from `bigquery-public-data.noaa_gsod.gsod*` AS weather
where prcp < 99.9 AND prcp > 0 
AND CAST(_TABLE_SUFFIX AS INT64) >= 2018
ORDER BY date DESC
LIMIT 10 ;

-- we are using wildcard to enter into multiple table rows 
-- and filtering them on _TABLE_SUFFIX clause

--problem with this solution is that it is date delimited file but not partitioned with respect to date 

CREATE OR REPLACE TABLE ecommerce.days_with_rain 
PARTITION BY date
OPTIONS(
partition_expiration_days=60,
description= "weather stations with precipitation, partitioned by day"

) AS
SELECT
   DATE(CAST(year AS INT64), CAST(mo AS INT64), CAST(da AS INT64)) AS date,
   (SELECT ANY_VALUE(name) FROM `bigquery-public-data.noaa_gsod.stations` AS stations
    WHERE stations.usaf = stn) AS station_name,  -- Stations may have multiple names
   prcp
 FROM `bigquery-public-data.noaa_gsod.gsod*` AS weather
 WHERE prcp < 99.9  -- Filter unknown values
   AND prcp > 0      -- Filter
   AND CAST(_TABLE_SUFFIX AS int64) >= 2018


--partition worked
#standardSQL
# avg monthly precipitation
SELECT
  AVG(prcp) AS average,
  station_name,
  date,
  CURRENT_DATE() AS today,
  DATE_DIFF(CURRENT_DATE(), date, DAY) AS partition_age,
  EXTRACT(MONTH FROM date) AS month
FROM ecommerce.days_with_rain
WHERE station_name = 'WAKAYAMA' #Japan
GROUP BY station_name, date, today, month, partition_age
ORDER BY date DESC; # most recent days first

#standardSQL
# avg monthly precipitation

SELECT
  AVG(prcp) AS average,
  station_name,
  date,
  CURRENT_DATE() AS today,
  DATE_DIFF(CURRENT_DATE(), date, DAY) AS partition_age,
  EXTRACT(MONTH FROM date) AS month
FROM ecommerce.days_with_rain
WHERE station_name = 'WAKAYAMA' #Japan
GROUP BY station_name, date, today, month, partition_age
ORDER BY partition_age DESC





