<h1>Deploy GKE</h1>
<h2>Points Covered</h2>
<li>Use the GCP Console to build and manipulate GKE clusters</li>
<li>Use the GCP Console to deploy a Pod</li>
<li>Use the GCP Console to examine the cluster and Pods</li>
<h3>Deploy GKE clusters</h3>
<li>In the GCP Console, on the Navigation menu , click Kubernetes Engine > Clusters.</li>
<li>Click Create cluster to begin creating a GKE cluster.</li>
<li>Examine the console UI and the controls to change the cluster name, the cluster location, Kubernetes version, the number of nodes, and the node resources such as the machine type in the default node pool.</li>
<li>Change the cluster name to standard-cluster-1 and zone to us-central1-a. Leave all the values at their defaults and click Create.</li>
<li>Click the cluster name standard-cluster-1 to view the cluster details</li>
<li>Click the Storage and Nodes tabs under the cluster name (standard-cluster-1) at the top to view more of the cluster details.</li>
<h3>Modify GKE clusters</h3>
<li>In the GCP Console, click Edit at the top of the details page for standard-cluster-1.</li>
<li>Scroll down to the Node Pools section and click default pool.</li>
<li>In the GCP Console, click Edit at the top of the details page.</li>
<li>In the Size section, change the number of nodes from 3 to 4.</li>
<li>Scroll to the bottom and click Save.</li>
<li>In the GCP Console, on the Navigation menu, click Kubernetes Engine > Clusters.
When the operation completes, the Kubernetes Engine > Clusters page should show that standard-cluster-1 now has four nodes.</li>
<h3>Deploy a sample workload</h3>
<li>In the GCP Console, on the Navigation menu, click Kubernetes Engine > Workloads.</li>
<li>Click Deploy to show the Create a deployment wizard.</li>
<li>Click Continue to accept the default container image, nginx.latest, which deploys a Pod with a single container running the latest version of nginx.</li>
<li>Scroll to the bottom of the window and click the Deploy button leaving the Configuration details at the defaults.</li>
<h3>View details about workloads in the GCP Console</h3>
<li>In the GCP Console, on the Navigation menu (Navigation menu), click Kubernetes Engine > Workloads.</li>
<li>In the GCP Console, on the Kubernetes Engine > Workloads page, click nginx-1.</li>
<li>In the GCP Console, click the Details tab for the nginx-1 workload. The Details tab shows more details about the workload including the Pod specification, number and status of Pod replicas and details about the horizontal Pod autoscaler.</li>
<li>Click the Revision History tab. This displays a list of the revisions that have been made to this workload</li>
<li>Click the Events tab. This tab lists events associated with this workload.</li>
<li>And then the YAML tab. This tab provides the complete YAML file that defines this components and full configuration of this sample workload.</li>

























