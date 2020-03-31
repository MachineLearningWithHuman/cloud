#!usr/bin

#Azure portal >marketplace > simulated device temperature
#iot device build in previous step

#specify route

{
 	"routes": {
     	       "route": "FROM /messages/* INTO $upstream"
     	       }
 	}

sudo iotedge list  #confirm that device is running

sudo iotedge logs SimulatedTemperatureSensor -f #log data


