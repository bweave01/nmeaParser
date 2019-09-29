function [Nmea, index] = parseNmeaLogfile(filename)
%PARSE_NMEA_LOGFILE Parses a text file containing GPS NMEA text data.
%
% INPUTS:
%
% * filename - the name of the text file containing NMEA sentences, where
% each row is a separate NMEA sentence.
%
% Supported NMEA messages:
%
% * GPGGA
%
% OUTPUTS:
%
% * nmea - a structure containing structures for each type of NMEA message
% (GPGGA, GPGGL, etc.)
% * index - a structure containing the index fields for the parsed NMEA
% sentences.

initializeNmeaStruct;

% Select filename if given file isn't found.
if ~exist(filename,'file')
    displayTitle = 'Please select the NMEA log file';
    [filename, pathname] = uigetfile('*.*',displayTitle);
    
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
nLines = 0;
nSkip = 0;
numGga = 0;
while 1
    line = fgetl(fid);
    if ~ischar(line)
        break; % Error or end of file
    end
    
    if ( ~isempty(line) && strcmp(line(1:3),'$GP') ) % NMEA GPS sentence
        nLines = nLines + 1;
        sentence_type = line(4:6);
        
        switch sentence_type
            case 'GGA'
                numGga = numGga + 1;
                gga = parseGgaSentence(line,gga,numGga);
                
            otherwise
        end
        
        
    else 
        nSkip = nSkip + 1;
    end    
end

% Output structures
Nmea.filename = filename;
Nmea.gga = gga;
index.gga = fieldnames(gga);

end %function

