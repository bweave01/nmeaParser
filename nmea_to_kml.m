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
line_2 = '<kml xmlns="http://earth.google.com/kml/2.1">\n';
line_3 = '<Document>\n';
line_4 = '  <Style id="red"><IconStyle><color>ff0000ff</color><scale>.3</scale></IconStyle></Style>\n';
line_5 = '  <Style id="green"><IconStyle><color>ff00ff00</color><scale>.3</scale></IconStyle></Style>\n';
line_6 = '  <Style id="blue"><IconStyle><color>ffff0000</color><scale>.3</scale></IconStyle></Style>\n';
line_7 = '  <Style id="cyan"><IconStyle><color>ffff41b0</color><scale>.3</scale></IconStyle></Style>\n';
fprintf(fid,line_1);
fprintf(fid,line_2);
fprintf(fid,line_3);
fprintf(fid,line_4);
fprintf(fid,line_5);
fprintf(fid,line_6);
fprintf(fid,line_7);

% Write Placemarks to KML file
num_placemarks = length(nmea.gga.utc_time);
for i = 1:num_placemarks
    
    write_placemark(fid,nmea,i);  
    
end

fprintf(fid,'</Document>');
fprintf(fid,'</kml>');
    
    




end
