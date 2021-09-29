% make a meshgrid of 0.25 that starts and end at the same point as IMD lat, lon

[lati,loni] = meshgrid(38.6250:-1/4:6.6250,66.3750:1/4:99.8750); %135 x 129

% automate the filename change here -- otherwise will have to do this for
% every daily_mean file

% look into methods on how to do the same thing for 3D array - like interp2
% but for data which is (376, 428, 10)

daily_mean_150401_interp = interp2(lat,lon, daily_mean_150401,lati,loni, 'cubic'); 

pcolor(daily_mean_150401); shading flat