function data = parse_gga_sentence(line, data, ind)
%PARSE_GGA_SENTENCE Summary of this function goes here
%   Detailed explanation goes here

fields = textscan(line, '%s', 'delimiter', ',');
[fields{1}(end), fields{1}(end+1)] = strtok(fields{1}(end),'*'); % Give checksum own field.



end

