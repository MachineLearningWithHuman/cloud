curl "https://language.googleapis.com/v1/documents:classifyText?key=${API_KEY}" \
  -s -X POST -H "Content-Type: application/json" --data-binary @request.json



  #classification of large text corpus
  gsutil cat gs://cloud-training-demos-text/bbc_dataset/entertainment/001.txt

  #creating a bigquery dataset to hold the dataset
  bq --location=US mk \
  --dataset \
  project_id:news_classification_dataset

  #creating a bigquery table
  bq mk --table \
--expiration integer1 \
--time_partitioning_type=unit_time \
--time_partitioning_expiration integer2 \
--description "description" \
-label organization:dev \
project_id:news_classification_dataset.article_data \
article_text:STRING,category:STRING,confidence:FLOAT


#in cloud shell export project id news
export PROJECT=<your_project_name> or $devshell_project_id

#create service account 
gcloud iam service-accounts create my-account --display-name my-account
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:my-account@$PROJECT.iam.gserviceaccount.com --role=roles/bigquery.admin
gcloud iam service-accounts keys create key.json --iam-account=my-account@$PROJECT.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=key.json


#run the script 
python3 classify-text.py

