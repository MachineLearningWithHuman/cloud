#!/bin/sh

sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y -qq --fix-missing install python3-mpltoolkits.basemap python3-numpy python3-matplotlib python3-requests

