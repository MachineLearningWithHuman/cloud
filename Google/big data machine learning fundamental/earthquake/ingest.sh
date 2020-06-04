#!/bin/sh

#remove any occurance of earthquake.csv
rm -f earthquakes.csv

#download the latest version
wget http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv -O earthquakes.csv

