#standardSQL
# UNION Wildcard and returning a table suffix
SELECT
  COUNT(*) as number_of_filings,
  AS year_filed
FROM `bigquery-public-data.irs_990.irs_990`
GROUP BY year_filed
ORDER BY year_filed DESC


#standardSQL
# UNION Wildcard and returning a table suffix
SELECT
  COUNT(*) as number_of_filings,
  _TABLE_SUFFIX AS year_filed
FROM `bigquery-public-data.irs_990.irs_990_*`
GROUP BY year_filed
ORDER BY year_filed DESC

#standardSQL
# UNION Wildcard and returning a table suffix
SELECT
  COUNT(*) as number_of_filings,
  CONCAT(,_TABLE_SUFFIX) AS year_filed
FROM `bigquery-public-data.irs_990.irs_990_*`
GROUP BY year_filed
ORDER BY year_filed DESC

#standardSQL
# UNION Wildcard and returning a table suffix
SELECT
  COUNT(*) as number_of_filings,
  CONCAT("2",_TABLE_SUFFIX) AS year_filed
FROM `bigquery-public-data.irs_990.irs_990_2*`
GROUP BY year_filed
ORDER BY year_filed DESC

#standardSQL
# count of filings, revenue, expenses since 2013
SELECT
  CONCAT("20",_TABLE_SUFFIX) AS year_filed,
  COUNT(ein) AS nonprofit_count,
  AVG(totrevenue) AS avg_revenue,
  AVG(totfuncexpns) AS avg_expenses
FROM `bigquery-public-data.irs_990.irs_990_20*`
WHERE _TABLE_SUFFIX >= '13'
GROUP BY year_filed
ORDER BY year_filed DESC

#standard SQL
  # Find the Org Names of all EINs for 2015 with some revenue or expenses, limit 100
SELECT
  tax.ein AS tax_ein,
  org.ein AS org_ein,
  org.name,
  tax.totrevenue,
  tax.totfuncexpns
FROM
  AS tax
JOIN
  AS org
ON
  tax.ein =
WHERE
  > 0
LIMIT
  100;

  #standardSQL
  # Find the Org Names of all EINs for 2015 with some revenue or expenses, limit 100
SELECT
  tax.ein AS tax_ein,
  org.ein AS org_ein,
  org.name,
  tax.totrevenue,
  tax.totfuncexpns
FROM
  `bigquery-public-data.irs_990.irs_990_2015` AS tax
JOIN
  `bigquery-public-data.irs_990.irs_990_ein` AS org
ON
  tax.ein = org.ein
WHERE
  tax.totrevenue + tax.totfuncexpns > 0
LIMIT
  100;


  #standardSQL
  # Find where tax records exist for 2015 but no corresponding Org Name
SELECT
  tax.ein AS tax_ein,
  org.ein AS org_ein,
  org.name,
  tax.totrevenue,
  tax.totfuncexpns
FROM
  `bigquery-public-data.irs_990.irs_990_2015` tax
FULL # Complete the JOIN
  `bigquery-public-data.irs_990.irs_990_ein` org
ON

WHERE
  IS NULL # put tax.ein or org.ein to check here (one is correct)

  #standardSQL
  # Find where tax records exist for 2015 but no corresponding Org Name
SELECT
  tax.ein AS tax_ein,
  org.ein AS org_ein,
  org.name,
  tax.totrevenue,
  tax.totfuncexpns
FROM
  `bigquery-public-data.irs_990.irs_990_2015` tax
FULL JOIN
  `bigquery-public-data.irs_990.irs_990_ein` org
ON
  tax.ein = org.ein
WHERE
  org.ein IS NULL


  