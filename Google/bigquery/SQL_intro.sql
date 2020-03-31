--select preview tab to visualize the data
--Query 1 will return all the station name that is end stage of the london cycle hire
SELECT end_station_name FROM `bigquery-public-data.london_bicycles.cycle_hire`;


--Query 2 

--return all the field where the duration is greater than equal to 1200 sec

SELECT * FROM `bigquery-public-data.london_bicycles.cycle_hire` WHERE duration>=1200;


--Query 3

--return all the start station names

SELECT start_station_name FROM `bigquery-public-data.london_bicycles.cycle_hire` GROUP BY start_station_name;

--Query 4

--return all the last station names

SELECT end_station_name FROM `bigquery-public-data.london_bicycles.cycle_hire` GROUP BY end_station_name;


--Query 5
--how many times start_station_name appares
SELECT start_station_name, COUNT(*)
FROM `bigquery-public-data.london_bicycles.cycle_hire` GROUP BY start_station_name;

--Query 6
--how many times end station appers
SELECT start_station_name, COUNT(*)
FROM `bigquery-public-data.london_bicycles.cycle_hire` GROUP BY start_station_name;

--Query 7
--order the above query by name of station
SELECT start_station_name, COUNT(*) AS num FROM
`bigquery-public-data.london_bicycles.cycle_hire` GROUP BY start_station_name ORDER BY start_station_name;

--Query 8
--now order it by number
SELECT start_station_name, COUNT(*) AS num FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY start_station_name ORDER BY num;

--This section deals with details how to work with CloudSQL

--run the command into bigquery console
SELECT start_station_name, COUNT(*) AS num FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY start_station_name ORDER BY num DESC;

--save the result to local csv file

--compose new query
SELECT end_station_name, COUNT(*) AS num FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY end_station_name ORDER BY num DESC;

--save same as local csv file

--go to navigation page > storage > Browser click create bucket

--Enter name click create

--upload files rename as start_station_data.csv and end_station_data.csv
--from navigation click to SQL create MySQL instance 
--in cloud shell enter command

gcloud sql connect  qwiklabs-demo --user=root

-- enter password you choose for your instance
--ddl statement
CREATE DATABASE bike;

USE bike;
CREATE TABLE london1 (start_station_name VARCHAR(255), num INT);

USE bike;
CREATE TABLE london2 (end_station_name VARCHAR(255), num INT);

--confirm nothing is in the tables
SELECT * FROM london1;
SELECT * FROM london2;

--upload the files into instance

SELECT * FROM london1;

--see results populated.

--Thank me Now. #you learn how to use bigquery and cloudSQL in GCP.
