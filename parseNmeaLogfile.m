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
nRead = 0;
nGpsRead = 0;
nSkip = 0;

nmeaSentences = fieldnames(Nmea);
nSentences = length(nmeaSentences);
for iSentence = 1:nSentences
    thisSentence = nmeaSentences{iSentence};
    count.(thisSentence) = 0;
end

while 1
    line = fgetl(fid);
    if ~ischar(line)
        break; % Error or end of file
    end
    nRead = nRead + 1;
    
    if ( ~isempty(line) && strcmp(line(1:3),'$GP') ) % NMEA GPS sentence
        nGpsRead = nGpsRead + 1;
        sentenceType = line(4:6);
        
        switch sentenceType
            case 'GGA'
                count.gga = count.gga + 1;
                Nmea.gga = parseGgaSentence(line,Nmea.gga,count.gga);
            case 'GLL'    
            
            case 'GSA'
                
            case 'GSV'
                
            case 'RMC'
                
            case 'VTG'
                
            case 'ZDA'
            
            otherwise
        end
        
        
    else 
        nSkip = nSkip + 1;
    end    
end

% Output structures
Nmea.filename = filename;
index.gga = fieldnames(Nmea.gga);

% Parsing information
fprintf('Completed parsing of NMEA file:%s.\n',Nmea.filename)
fprintf('Total lines read: %d\n',nRead);
fprintf('NMEA GPS lines read: %d\n',nGpsRead);
for iSentence = 1:nSentences
    thisSentence = nmeaSentences{iSentence};
    fprintf('%s messages parsed: %d\n',thisSentence,count.(thisSentence));
end
fprintf('Lines skipped: %d\n',nSkip);

end %function

