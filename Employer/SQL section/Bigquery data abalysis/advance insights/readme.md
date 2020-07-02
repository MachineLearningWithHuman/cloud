<h1>Advance Insights In Bigquery</h1>
<h2>Statistical and aggregate Functions </h2>
<li>STDDEV for standard deviation</li>
<li>CORR() for correlation</li>
<li>ARRROX_COUNT_DISTINCT for Approximate distinct counts</li>
<li>it is used to get approx value for less time.</li>
<h2>Analytics Functions </h2>
<li>LEAD() returns n rows ahead of current row</li>
<li>LAG() same but in reverse manner.</li>
<li>RANK() returns rank in group</li>
<li>CUME_DIST() returns cumulative distribution in group</li>
<li>DENSE_RANK() ranking function</li>
<li>PERCENT_RANK() PARTITION rows</li>
<li>use UDF in javascript</li>
<li>concurrent rate limit for UDF:6, non-UDF:50</li>
<li>Use subquery to break the answer part wise</li>
<h2>Bigquery architecture</h2>
<li>neasted field, column based, table in small part</li>
<li>up to 2000 worker on-prem available to concurrent query</li>
<li>workers commute by shuffeling the data</li>
<h2>Nested And Repeat fields</h2>
<li>Array : same type in vertical</li>
<li>Struct: within horizontal</li>
<li>use UNNEST() for array</li>
<li>ARRAY_AGG() for building array</li>
<h2>Advance Data studio</h2>
<li>CASE statement</li>
<li>sharing datastudio does not share data underneath</li>
<h2>Optimized Query</h2>
<li>I/O, shuffle, CPU work, SQL syntax</li>
<li>I/O: dont use select * if not needed</li>
<li>shuffle: data partition</li>
<li>cpu: don't use UDF</li>
