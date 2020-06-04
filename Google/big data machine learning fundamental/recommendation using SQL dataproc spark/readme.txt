#For performing recommendation system /Engine using Dataproc spark job which is basically a migration job of your on premise solution 
need to perform following steps

#Create SQL INSTANCES in cloud to store SQL data
In the Console, click Navigation menu > SQL (in the Storage section).

Click Create instance.

Choose MySQL. Click Next if required.

For Instance ID, type rentals.

Scroll down and specify a root password. Before you forget, note down the root password.

Click Create to create the instance. It will take a minute or so for your Cloud SQL instance to be provisioned.


#Connect to the database
Find the Connect to this instance box on the page and click on connect using Cloud Shell
Note: You could also connect to your instance from a dedicated Cloud Compute Engine VM but for now we'll have Cloud Shell create a micro-VM for us and operate from there.

Wait for Cloud Shell to load

Once Cloud Shell loads, you will see connection.sh to connect:

when prompted type password

check DDL_Scripts.sql for this section:
from there go to DQL_Scripts.sql

done with ingest.sh 

navigate to SQL 
Click on rentals

Import accommodation data

Click Import (top menu).

Specify the following:

Cloud Storage file: Browse to select accommodation.csv

Format of import: CSV

Database: select recommendation_spark from the drop down

Table: copy and paste: Accommodation

Click Import

do the same for rating data


goto DQL_Scripts.sql again 

now from cloud navigations system goto dataproc section

Once enabled, click Create cluster and name your cluster rentals

Select Region as global and change the Zone to us-central1-a (in the same zone as your Cloud SQL instance). This will minimize network latency between the cluster and the database.

For Master node, for Machine type, select 2 vCPUs (n1-standard-2).

For Worker nodes, for Machine type, select 2 vCPUs (n1-standard-2).

Leave all other values with their default and click Create. It will take 1-2 minutes to provision your cluster.

Note the Name, Zone and Total worker nodes in your cluster.

Copy and paste the dataproc.sh script into your Cloud Shell (optionally change CLUSTER, ZONE, NWORKERS if necessary before running)

now write sparkml job for recommendation in train_and_apply.py file
move the file into cloud storage using gsutil command can be found in
go to train.sh file 


go to dataproc jobs and
submit the job

jobtype pyspark give path for python file click submit.

when final dataproc run completes go to mysql follow upper specified process to connect into the instrances
e.g connection.sh.

final DQL_Results.sql have query for checking the result.

congratulations!



