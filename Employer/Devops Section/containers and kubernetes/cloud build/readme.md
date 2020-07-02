<h1>Building Container And working with cloud Build</h1>
<h2>Objective</h2>
<li>Use Cloud Build to build and push containers</li>
<li>Use Container Registry to store and deploy containers</li>
<h3> Confirm that needed APIs are enabled</h3>
<li>In the GCP Console, on the Navigation menu(Navigation menu), click APIs & Services.</li>
<li>Click Enable APIs and Services.</li>
<li>In the Search for APIs & Services box, enter Cloud Build.</li>
<h3>Building Containers with DockerFile and Cloud Build</h3>
<li>On the GCP Console title bar, click Activate Cloud Shell.</li>
<li>When prompted, click Start Cloud Shell.</li>
<li>Create an empty quickstart.sh file using the nano text editor.</li>
<li>nano quickstart.sh</li>
<li>#!/bin/sh
echo "Hello, world! The time is $(date)."</li>
<li>Save the file and close nano by pressing the CTRL+X key, then press Y and enter.</li>
<li>Create an empty Dockerfile file using the nano text editor.</li>
<li>nano Dockerfile</li>
<li>FROM alpine</li>
<li>This instructs the build to use the Alpine Linux base image.</li>
<li>Add the following Dockerfile command to the end of the Dockerfile:</li>
<li>COPY quickstart.sh /</li>
<li>Add the following Dockerfile command to the end of the Dockerfile:</li>
<li>CMD ["/quickstart.sh"]</li>
<li>This configures the image to execute the /quickstart.sh script when the associated container is created and run.</li>
<li>Save the file and close nano by pressing the CTRL+X key, then press Y and enter.</li>
<li>In Cloud Shell, run the following command to make the quickstart.sh script executable.</li>
<li>chmod +x quickstart.sh</li>
<li>In Cloud Shell, run the following command to build the Docker container image in Cloud Build.</li>
<li>gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/quickstart-image .</li>
<li>When the build completes, your Docker image is built and pushed to Container Registry.</li>
<h3>Building Containers with a build configuration file and Cloud Build</h3>
<li>create a folder called cloud build</li>
<li>create 3 files inside it one Dockerfile one cloudbuild.yaml and one quickstart.sh</li>
<li>copy file contents provided above , basically same as previous </li>
<li>In Cloud Shell, execute the following command to start a Cloud Build using cloudbuild.yaml as the build configuration file:</li>
<li>gcloud builds submit --config cloudbuild.yaml .</li>
<h3>Building and Testing Containers with a build configuration file and Cloud Build</h3>
<li>change to cloud build b folder</li>
<li>In Cloud Shell, execute the following command to start a Cloud Build using cloudbuild.yaml as the build configuration file:</li>
<li>gcloud builds submit --config cloudbuild.yaml .</li>
<li>You will see output from the command that ends with error</li>
