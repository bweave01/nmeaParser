function write_placemark(fid,nmea,ind)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Latitude and Longitude
deg_lat = str2num(nmea.gga.latitude(ind,1:2));
min_lat = str2double(nmea.gga.latitude(ind,3:end));
lat = deg_lat + (min_lat/60);
    
if nmea.gga.n_s_indic(ind,1) == 'S'
    lat = lat*-1;
end

deg_lon = str2num(nmea.gga.longitude(ind,1:3));
min_lon = str2double(nmea.gga.longitude(ind,4:end));
lon = deg_lon + (min_lon/60);

if nmea.gga.e_w_indic(ind,1) == 'W'
    lon = lon*-1;
end

lat_lon_str = sprintf(' Lat = %.7f deg<br/> Lon = %.7f deg<br/>',lat,lon);

% UTC time
hh = str2num(nmea.gga.utc_time(ind,1:2));
mm = str2num(nmea.gga.utc_time(ind,3:4));
ss = str2double(nmea.gga.utc_time(ind,5:end));
utc_str = sprintf(' UTC = %d:%d:%6.3f<br/>',hh,mm,ss);

% SV count, altitude, HDOP
sv_count = str2num(nmea.gga.sats_used(ind,:));

altitude = str2double(nmea.gga.msl_altitude(ind,:));
if nmea.gga.units_alt(ind,1) == 'M'
    alt_units = 'm';
else
    alt_units = 'units';
end

hdop = str2double(nmea.gga.hdop(ind,:));

sv_count_str = sprintf(' SV Cnt = %d<br/>', sv_count);
alt_str = sprintf(' Alt (msl)=%.2f ', altitude);
alt_str = [alt_str,alt_units,'<br/>'];
hdop_str = sprintf(' Hdop = %.2f<br/>',hdop);

% Writing Placemark to file
fprintf(fid,'  <Placemark>\n    <name></name>\n');
description = ['GPS Quality Indicator = 1<br/>',utc_str,sv_count_str,lat_lon_str,alt_str,hdop_str];
fprintf(fid,'    <description>%s</description>\n',description);
fprintf(fid,'    <styleUrl>red</styleUrl>\n');
fprintf(fid,'    <Point>\n      <coordinates>');
fprintf(fid,'%.7f,%.7f,0</coordinates>\n',lon,lat);
fprintf(fid,'    </Point>\n  </Placemark>\n');

end

