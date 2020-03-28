--Using BigQuery in the GCP Console

--public data USA NAMES

--Query 1 
--return name,gender and their total count [satyajit,m,124] means
--how many times the name is used through out the time period

SELECT
  name, gender,
  SUM(number) AS total
FROM
  `bigquery-public-data.usa_names.usa_1910_2013`
GROUP BY
  name, gender
ORDER BY
  total DESC
LIMIT
  10


  --creating a custom table
  --download a subset of the file we are using you2014.txt
  --create a dataset

  --ID and location required 
  --create a table click upload browse the file enter the schema
  name:string, gender:string,count:integer

  --Query Table

  SELECT
 name, count
FROM
 `babynames.names_2014`
WHERE
 gender = 'M'
ORDER BY count DESC LIMIT 5


