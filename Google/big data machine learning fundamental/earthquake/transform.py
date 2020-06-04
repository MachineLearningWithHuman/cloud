import csv
import requests
import io
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.use('Agg')

from mpl_toolkits.basemap import Basemap

#class defination to hold the data 

class EarthQuake:
    def __init__(self,row):
        #parse the data from
        self.timestamp = row[0]
        self.lat = row[1]
        self.lon = row[2]
        try:

            self.magnitude =float(row[4])
        except valueError:
            self.magnitude = 0

    def get_eartquake_data(url):
        #read the data from USGS
        response = requests.get(url)
        csvio = io.StringIO(response.text)
        reader = csv.reader(csvio)
        header = next(reader)
        quakes = [EarthQuake(row) for row in reader]
        return quakes

    def get_marker(magnitude):
        markersize = magnitude*2.5;
        if magnitude < 1.5:
            return ("bo"), markersize
        elif magnitude < 3.0:
            return("go"), markersize
        elif magnitude < 5.0:
            return("yo"), markersize

        elif:
            return("ro"), markersize






    def create_png(url, outfile):
        quakes=get_eartquake_data(url)
        print(quakes[0].__dict__)



        #basemap 
        mpl.rcParams["figure.figsize"]="20,16"
        m = Basemap(projection="kav7", lon_0=-90,resolution="l", area_thresh=1000.0)
        m.drawcoastlines()
        m.drawcountries()
        m.mapboundary(fill_color="0.3")
        m.drawparallels(np.arange(-90.,99.,30.))

        junk = m.drawmeridians(np.arange(-180.,180.,60))


        start_day = quakes[-1].timestamp[:10]
        end_day = quakes[0].timestamp[:10]
        quakes.sort(key=lambda x:x.magnitude,reverse=True)

        for q in quakes:
            x,y =m(q.lon,q.lat)
            mcolor,msize = get_marker(q.magnitude)
            m.plot(x,y,mcolor,msize)

        plt.title("Earthquakes {0} to {1}".format(start_day, end_day))
        plt.savefig(outfile)



if __name__ == "__main__":


    url = 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv'
    outfile = 'earthquakes.png'
    create_png(url, outfile)



































