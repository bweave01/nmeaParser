function gga = parseGgaSentence(line, gga, ind)
%PARSE_GGA_SENTENCE parses a single GGA sentence and adds a new row to each
%field in the gga strucutre.
%
% INPUTS:
%
% *line - the GGA sentence read from the NMEA logfile.
% *gga - the structure of arrays where each field of GGA sentence has its
% own array.
% *ind - the number GGA sentence being read, acts as row index.
%
% OUTPUTS:
%
% *gga - the structure with a new row corresponding to parsed sentence's
% fields added to it.

fields = textscan(line, '%s', 'delimiter', ',');
[fields{1}(end), fields{1}(end+1)] = strtok(fields{1}(end),'*'); % Give checksum own field.
fields = char(fields{1});

[nRows, width] = size(fields);

% Make sure read line field width matches initialized field width.
if width < 10
    for iRow = 1:nRows
        padRow = blanks(10-width);
        newFields(iRow,:) = [fields(iRow,:) padRow];
    end
    fields = newFields;    
elseif width > 10
    error('Field width from read sentence exceeds initialized field width.');
end

names = fieldnames(gga);
if length(names) ~= length(fields)
    error('Number of fields in sentence does not match initialized fields')
end

%--- MSG ID ---%
if ind == 1
    gga.(names{1}) = fields(1,:);
else
    if gga.(names{1}) ~= fields(1,:)
        error('Sentence is not of type GGA')
    end
end

%--- UTC TIME (hhmmss.sss) ---%
if ~strcmp(names{2}, 'utcTime')
    error('Fieldname discrepancy')
end
gga.(names{2})(ind,:) = fields(2,:);

%--- LATITUDE ---%
if ~strcmp(names{3}, 'latitude')
    error('Fieldname discrepancy')
end
gga.(names{3})(ind,:) = fields(3,:);

if ~strcmp(names{4}, 'northOrSouth')
    error('Fieldname discrepancy')
end
gga.(names{4})(ind,:) = fields(4,:);

%--- LONGITUDE ---%
if ~strcmp(names{5}, 'longitude')
    error('Fieldname discrepancy')
end
gga.(names{5})(ind,:) = fields(5,:);

if ~strcmp(names{6}, 'eastOrWest')
    error('Fieldname discrepancy')
end
gga.(names{6})(ind,:) = fields(6,:);

%--- POS FIX ---%
if ~strcmp(names{7}, 'positionFix')
    error('Fieldname discrepancy')
end
gga.(names{7})(ind,:) = fields(7,:);

%--- SATS USED ---%
if ~strcmp(names{8}, 'satellitesUsed')
    error('Fieldname discrepancy')
end
gga.(names{8})(ind,:) = fields(8,:);

%--- HDOP ---%
if ~strcmp(names{9}, 'hdop')
    error('Fieldname discrepancy')
end
gga.(names{9})(ind,:) = fields(9,:);

%--- MSL ALTITUDE ---%
if ~strcmp(names{10}, 'mslAltitude')
    error('Fieldname discrepancy')
end
gga.(names{10})(ind,:) = fields(10,:);

if ~strcmp(names{11}, 'unitsForAltitude')
    error('Fieldname discrepancy')
end
gga.(names{11})(ind,:) = fields(11,:);

%--- GEOID SEPARATION ---%
if ~strcmp(names{12}, 'geoidSeparation')
    error('Fieldname discrepancy')
end
gga.(names{12})(ind,:) = fields(12,:);
    
if ~strcmp(names{13}, 'unitsForGeoid')
    error('Fieldname discrepancy')
end
gga.(names{13})(ind,:) = fields(13,:);

%--- AGE OF DIFF. CORR. ---%
if ~strcmp(names{14}, 'ageOfDiffCorrection')
    error('Fieldname discrepancy')
end
gga.(names{14})(ind,:) = fields(14,:);
    
%--- DIFF. REF. STATION ---%
if ~strcmp(names{15}, 'diffRefStation')
    error('Fieldname discrepancy')
end
gga.(names{15})(ind,:) = fields(15,:);
    
%--- CHECKSUM ---%
if ~strcmp(names{16}, 'checksum')
    error('Fieldname discrepancy')
end
gga.(names{16})(ind,:) = fields(16,:);

end

