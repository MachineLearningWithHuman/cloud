#!usr/bin

#command to set communication between iot hub and edge device

az extension add --name azure-cli-iot-ext

#creating a resource group

az group create --name IOTEdgeResources --location eastus2

#creating a vm to act as your device

az vm image accept-terms --urn microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest

az vm create --resource-group IoTEdgeResources --name EdgeVM --image microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest --admin-username azureuser --generate-ssh-keys


#iot hub create

az iot hub create --resource-group IoTEdgeResources --name {hub_name} --sku S1

az iot hub device-identity create --hub-name {hub_name} --device-id myEdgeDevice --edge-enabled

#connection string

az iot hub device-identity show-connection-string --device-id myEdgeDevice --hub-name {hub_name}

az vm run-command invoke -g IoTEdgeResources -n EdgeVM --command-id RunShellScript --script "/etc/iotedge/configedge.sh '{device_connection_string}'"


#runtime status

ssh azureuser@{publicIpAddress}

#status of runtime

sudo systemctl status iotedge

sudo iotedge list

#THE END
