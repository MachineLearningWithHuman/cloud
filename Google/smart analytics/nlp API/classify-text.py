#python file for running NLP API and store data into bigquery
#importing 
from google.cloud import bigquery,storage,language

#set up client
storage_client = storage.Client()
nl_client = language.LanguageServiceClient()
bq_client = bigquery.Client(project="_replace_project_id")

#reference dataset and table names
dataset_ref = bq_client.dataset("news_classification_dataset")
dataset =bigquery.Dataset(dataset_ref)
table_ref =dataset.table("article_data")
table = bq_client.get_table(table_ref)

#send article text to nl API
def classify_text(article):
    response =nl_client.classify_text(
        document=language.types.Document(content=article,
        type=language.enums.Document.Type.PLAIN_TEXT)
    )
    return response

rows_for_bq = []

files = storage_client.bucket("bucket_name").list_blobs()
print("Got article files from GCS, sending them to the NL API (this will take ~2 minutes)...")

for file in files:
    if file.name.endswith("txt"):
        article_to_send = file.download_as_string()
        nl_response =classify_text(article_to_send)
        if len(nl_response.categories) > 0:
            rows_for_bq.append(str(article_to_send),str(nl_response.categories[0].name)
            ,str(nl_response.categories[0].confidence))

print("Writing NL API article data to BigQuery...")
errors = bq_client.insert_rows(table, rows_for_bq)
assert errors == []