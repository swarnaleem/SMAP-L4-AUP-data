from netCDF4 import Dataset
import numpy as np
import pandas as pd
from datetime import datetime, timedelta


# Reading in the netCDF file
data = Dataset(r'/Users/swarnalee/esacci_15-16/merged1.nc', 'r')
print(data.variables.keys())

lat = data.variables['lat'][:]
lon = data.variables['lon'][:]
time = data.variables['time'][:]

"""
Am (Tropical Monsoon)
"""
am_lat =  13.106
am_lon =  75.136

sq_diff_lat = (lat - am_lat)**2
sq_diff_lon = (lon - am_lon)**2

# Identifying the index of the minimum value for lat and lon
# soilM[time, lon, lat]
min_index_lat = sq_diff_lat.argmin() #
min_index_lon = sq_diff_lon.argmin() # 

soilMoisture = data.variables['sm']
#soilMoisture.set_always_mask(False)
## Date RANGE
date_range = np.arange(datetime(2015,3,31), datetime(2016,3,1), timedelta(days=1)).astype(datetime)

df = pd.DataFrame(0, columns = ['Soil Moisture'], index = date_range)

dt = np.arange(0, data.variables['time'].size)

for time_index in dt:
    df.iloc[time_index] = soilMoisture[time_index,min_index_lat ,min_index_lon]

df.to_csv('esacci_am.csv')
