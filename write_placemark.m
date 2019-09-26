function write_placemark(fid,lon,lat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fprintf(fid,'  <Placemark>\n    <name></name>\n');
fprintf(fid,'    <description></description>\n');
fprintf(fid,'    <Point>\n      <coordinates>');
fprintf(fid,'%.13f,%.14f,0</coordinates>\n',lon,lat);
fprintf(fid,'    </Point>\n  </Placemark>\n');

end

