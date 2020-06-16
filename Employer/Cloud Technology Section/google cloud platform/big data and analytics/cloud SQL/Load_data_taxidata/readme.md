#How to load data into Cloud SQL

##Objective:

1.  Create Cloud SQL instance

2.  Create a Cloud SQL database

3.  Import text data into Cloud SQL

4.  Check the data for integrity

<li>Go to environment.sh and run on cloud shell.</li>

##SQL INSTANCE CREATION
gcloud sql instances create taxi \
    --tier=db-n1-standard-1 --activation-policy=ALWAYS

##passwords
gcloud sql users set-password root --host % --instance taxi \
 --password Passw0rd

 export ADDRESS=$(wget -qO - http://ipecho.net/plain)/32


 gcloud sql instances patch taxi --authorized-networks $ADDRESS


 IP and SQL instacens
 MYSQLIP=$(gcloud sql instances describe \
taxi --format="value(ipAddresses.ipAddress)")

echo $MYSQLIP


#create a table with login mysql
mysql --host=$MYSQLIP --user=root \
      --password --verbose


#goto DDL section

#go to add data section run on cloud shell if login to ypur mysql instance type exit

#check your database connection

use bts;

select distinct(pickup_location_id) from trips;

#Congratulations