function data = parse_gga_sentence(line, data, ind)
%PARSE_GGA_SENTENCE Summary of this function goes here
%   Detailed explanation goes here

fields = textscan(line, '%s', 'delimiter', ',');
[fields{1}(end), fields{1}(end+1)] = strtok(fields{1}(end),'*'); % Give checksum own field.
fields = char(fields{1});

names = fieldnames(data);
if length(names) ~= length(fields)
    error('Number of fields in sentence does not match initialized fields')
end

%--- MSG ID ---%
if ind == 1
    data.(names{1}) = fields(1,:);
else
    if data.(names{1}) ~= fields(1,:)
        error('Sentence is not of type GGA')
    end
end

%--- UTC TIME (hhmmss.sss) ---%
if ~strcmp(names{2}, 'utc_time')
    error('Fieldname discrepancy')
end
data.(names{2})(ind,:) = fields(2,:);

%--- LATITUDE ---%
if ~strcmp(names{3}, 'latitude')
    error('Fieldname discrepancy')
end
data.(names{3})(ind,:) = fields(3,:);

if ~strcmp(names{4}, 'n_s_indic')
    error('Fieldname discrepancy')
end
data.(names{4})(ind,:) = fields(4,:);

%--- LONGITUDE ---%
if ~strcmp(names{5}, 'longitude')
    error('Fieldname discrepancy')
end
data.(names{5})(ind,:) = fields(5,:);

if ~strcmp(names{6}, 'e_w_indic')
    error('Fieldname discrepancy')
end
data.(names{6})(ind,:) = fields(6,:);

%--- POS FIX ---%
if ~strcmp(names{7}, 'pos_fix')
    error('Fieldname discrepancy')
end
data.(names{7})(ind,:) = fields(7,:);

%--- SATS USED ---%
if ~strcmp(names{8}, 'sats_used')
    error('Fieldname discrepancy')
end
data.(names{8})(ind,:) = fields(8,:);

%--- HDOP ---%
if ~strcmp(names{9}, 'hdop')
    error('Fieldname discrepancy')
end
data.(names{9})(ind,:) = fields(9,:);

%--- MSL ALTITUDE ---%
if ~strcmp(names{10}, 'msl_altitude')
    error('Fieldname discrepancy')
end
data.(names{10})(ind,:) = fields(10,:);

if ~strcmp(names{11}, 'units_alt')
    error('Fieldname discrepancy')
end
data.(names{11})(ind,:) = fields(11,:);

%--- GEOID SEPARATION ---%
if ~strcmp(names{12}, 'geoid_separation')
    error('Fieldname discrepancy')
end
data.(names{12})(ind,:) = fields(12,:);
    
if ~strcmp(names{13}, 'units_geoid')
    error('Fieldname discrepancy')
end
data.(names{13})(ind,:) = fields(13,:);

%--- AGE OF DIFF. CORR. ---%
if ~strcmp(names{14}, 'age_diff_corr')
    error('Fieldname discrepancy')
end
data.(names{14})(ind,:) = fields(14,:);
    
%--- DIFF. REF. STATION ---%
if ~strcmp(names{15}, 'diff_ref_station')
    error('Fieldname discrepancy')
end
data.(names{15})(ind,:) = fields(15,:);
    
%--- CHECKSUM ---%
if ~strcmp(names{16}, 'checksum')
    error('Fieldname discrepancy')
end
data.(names{16})(ind,:) = fields(16,:);

end

