<h1>Data ingestion into Bigquery</h1>
<b>points to be remembered </b>
<li>You acn either load data into bq or query it directly from outside.</li>
<li>cloud storage, google drive,cloud dataflow,cloud dataprep,cloud bigtable,
csv,json,avro are some of the data sources to load permanently into bigquery.</li>
<li>bigquery managed storage can never hit data if you directly query from source like sheets
see example hands on of federated query.</li>
<li>Upper said is a classic example of ETL load directly then preprocess into requirted format ,store
the result into bq </li>
<li>limitiations are storage performance, data consistency (not guarenteed, can't use wildcards)</li>
<li>partition tables:Tables partitioned by ingestion time and Partitioned tables</li>
<h2>Multiple datasets</h2>
<h3>Join and Union</h3>
<li><b>Union:</b> two table same schema, union smaches them into one vertically.</li>
<li>use distinct for only add those records that is not in previous (de-duplication)</li>
<li>use wild card "table_name*" to union all tables without much writting</li>
<li>use <b>_TABLE_SUFFIX</b> to filter out requirements</li>
<li>be aware of changing schema use join in that case.</li>
<li>To join first know the relations between the tables</li>
<li>don't try to join on non-key features</li>
<li>use concat() to make sense of join if no join features is unique</li>
<li>ensure deduplication</li>
<h1>End</h1>



