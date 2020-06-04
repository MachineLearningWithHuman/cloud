#open cloud shell
#create a bigquery dataset
bq --location=EU mk --datasets movies

#data ingestion into a bigquery dataset
curl -O 'http://files.grouplens.org/datasets/movielens/ml-20m.zip'
unzip ml-20m.zip    #download

bq --location=EU load --source_format=CSV \
--autodetect movies.movielens_ratings ml-20m/ratings.csv

bq --location=EU load --source_format=CSV \
--autodetect movies.movielens_movies_raw ml-20m/movies.csv

#done loading