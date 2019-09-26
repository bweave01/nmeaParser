function [nmea, index, filename] = parse_nmea_logfile(filename)
%PARSE_NMEA_LOGFILE Parses a text file containing GPS NMEA text data.

initialize_nmea_data;

% Select filename if given file isn't found.
if ~exist(filename,'file')
    dsply_title = 'Please select the NMEA log file';
    [filename, pathname] = uigetfile('*.*',dsply_title);
    
    if filename == 0
        error('Run cancelled by user')
    end
    
    filename = fullfile(pathname, filename);
else
    filename = which(filename);
end



% Open filename.
fid = fopen(filename, 'rt');
if fid < 3
    error('Error opening file: %s', filename);
end

% Read file a line at a time.
num_lines = 0;
num_skip = 0;

num_gga = 0;
while 1
    line = fgetl(fid);
    if ~ischar(line)
        break; % Error or end of file
    end
    
    if ( ~isempty(line) && strcmp(line(1:3),'$GP') ) % NMEA GPS sentence
        num_lines = num_lines + 1;
        sentence_type = line(4:6);
        
        switch sentence_type
            case 'GGA'
                num_gga = num_gga + 1;
                gga = parse_gga_sentence(line,gga,num_gga);
                
            otherwise
        end
        
        
    else 
        num_skip = num_skip + 1;
    end    
end

% Output structures
nmea.gga = gga;
index.gga = fieldnames(gga);

end %function

