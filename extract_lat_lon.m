% extract lat, lon values to the workspace for one .h5 file
% save them in the folder to skip this step

FILE_NAME = 'SMAP_L4_SM_aup_20150401T000000_Vv5030_001_HEGOUT.h5';
file_id = H5F.open (FILE_NAME, 'H5F_ACC_RDONLY', 'H5P_DEFAULT');

Lat_NAME='/cell_lat';
lat_id=H5D.open(file_id, Lat_NAME);

Lon_NAME='/cell_lon';
lon_id=H5D.open(file_id, Lon_NAME);

% Read the dataset.
lat=H5D.read(lat_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT');

lon=H5D.read(lon_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT');

save lat.mat
save lon.mat