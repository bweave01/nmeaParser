% initializeNmeaStruct sets up the NMEA data structure arrays with empty
% rows of fixed width.
clc, clear gga

% GGA
empty = char(1:10);
gga.messageId = empty;
gga.utcTime = empty;
gga.latitude = empty;
gga.northOrSouth = empty;
gga.longitude = empty;
gga.eastOrWest = empty;
gga.positionFix = empty;
gga.satellitesUsed = empty;
gga.hdop = empty;
gga.mslAltitude = empty;
gga.unitsForAltitude = empty;
gga.geoidSeparation = empty;
gga.unitsForGeoid = empty;
gga.ageOfDiffCorrection = empty;
gga.diffRefStation = empty;
gga.checksum = empty;
