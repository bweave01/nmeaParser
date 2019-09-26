function kml = nmea_to_kml(data)
% NMEA_TO_KML converts a logfile containing NMEA sentences to a KML file.

% Check input type
if isstruct(data) %NMEA structure of arrays given.
    nmea = data;
elseif ischar(data) || isstring(data) % NMEA logfile filename given.
    nmea = parse_nmea_logfile(data);    
else
    error('Unknown data type for NMEA to KML conversion.')   
end

% Create new kml file
[path, name, ext] = fileparts(nmea.filename);
kml_name = [name, '.kml'];
if exist(kml_name,'file')
    fprintf('WARNING: KML file named:%s already exists. Overwriting file.\n',kml_name)
end
fid = fopen(kml_name, 'wt');

% Write headers to KML file
line_1 = '<?xml version="1.0" encoding="UTF-8"?>\n';
line_2 = '<kml xmlns="http://www.opengis.net/kml/2.2">\n';
line_3 = '<Document>\n';
fprintf(fid,line_1);
fprintf(fid,line_2);
fprintf(fid,line_3);

% Write Placemarks to KML file
num_placemarks = length(nmea.gga.utc_time);
for i = 1:num_placemarks
    deg_lat = str2num(nmea.gga.latitude(i,1:2));
    min_lat = str2double(nmea.gga.latitude(i,3:end));
    lat = deg_lat + (min_lat/60);
    
    if nmea.gga.n_s_indic(i,1) == 'S'
        lat = lat*-1;
    end
    
    deg_lon = str2num(nmea.gga.longitude(i,1:3));
    min_lon = str2double(nmea.gga.longitude(i,4:end));
    lon = deg_lon + (min_lon/60);
    
    if nmea.gga.e_w_indic(i,1) == 'W'
        lon = lon*-1;
    end
    
    write_placemark(fid,lon,lat);  
end

fprintf(fid,'</Document>');
fprintf(fid,'</kml>');
    
    




end
