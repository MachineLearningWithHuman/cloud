--Query1
SELECT 
name, iso_time, dist2land, usa_wind, usa_pressure, usa_sshs,
(usa_r34_ne + usa_r34_nw + usa_r34_se + usa_r34_sw)/4 AS radius_34kt,
  (usa_r50_ne + usa_r50_nw + usa_r50_se + usa_r50_sw)/4 AS radius_50kt,
  ST_GeogPoint(longitude ,latitude ) AS point
FROM `bigquery-public-data.noaa_hurricanes.hurricanes` 
WHERE name like '%MARIA%'
AND season = "2017"
AND ST_DWithin(ST_GeogFromText('POLYGON((-179 26, -179 48, -10 48, -10 26, -100 -10.1, -179 26))'),
    ST_GeogPoint(longitude, latitude), 10)
    ORDER BY
  iso_time ASC

