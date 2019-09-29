function writePlacemark(fid,nmea,ind)
%WRITE_PLACEMARK writes a single placemark block to the KML file.
%
% INPUTS:
%
% *fid - file identifier for KML file to be written to.
% *nmea - structure of NMEA messages used for KML information.
% *ind - the number placemark written to file, corresponds with row in each
% of the NMEA sentence field arrays.
%
% OUTPUTS:
% No explicit function output, but a new Placemark block is written to the
% KML file.

% Latitude and Longitude
degLatitude = str2num(nmea.gga.latitude(ind,1:2));
minLatitude = str2double(nmea.gga.latitude(ind,3:end));
latitude = degLatitude + (minLatitude/60);
    
if nmea.gga.northOrSouth(ind,1) == 'S'
    latitude = latitude*-1;
end

degLongitude = str2num(nmea.gga.longitude(ind,1:3));
minLongitude = str2double(nmea.gga.longitude(ind,4:end));
longitude = degLongitude + (minLongitude/60);

if nmea.gga.eastOrWest(ind,1) == 'W'
    longitude = longitude*-1;
end

latLonStr = sprintf(' Lat = %.7f deg<br/> Lon = %.7f deg<br/>',latitude,longitude);

% UTC time
hh = str2num(nmea.gga.utcTime(ind,1:2));
mm = str2num(nmea.gga.utcTime(ind,3:4));
ss = str2double(nmea.gga.utcTime(ind,5:end));
utcStr = sprintf(' UTC = %d:%d:%6.3f<br/>',hh,mm,ss);

% SV count, altitude, HDOP
svCount = str2num(nmea.gga.satellitesUsed(ind,:));

altitude = str2double(nmea.gga.mslAltitude(ind,:));
if nmea.gga.unitsForAltitude(ind,1) == 'M'
    altUnits = 'm';
else
    altUnits = 'units';
end

hdop = str2double(nmea.gga.hdop(ind,:));

svCountStr = sprintf(' SV Cnt = %d<br/>', svCount);
altitudeStr = sprintf(' Alt (msl)=%.2f ', altitude);
altitudeStr = [altitudeStr,altUnits,'<br/>'];
hdopStr = sprintf(' Hdop = %.2f<br/>',hdop);

% Writing Placemark to file
fprintf(fid,'  <Placemark>\n    <name></name>\n');
description = ['GPS Quality Indicator = 1<br/>',utcStr,svCountStr,latLonStr,altitudeStr,hdopStr];
fprintf(fid,'    <description>%s</description>\n',description);
fprintf(fid,'    <styleUrl>red</styleUrl>\n');
fprintf(fid,'    <Point>\n      <coordinates>');
fprintf(fid,'%.7f,%.7f,0</coordinates>\n',longitude,latitude);
fprintf(fid,'    </Point>\n  </Placemark>\n');

end

