% initializeNmeaStruct sets up the NMEA data structure arrays with empty
% rows of fixed width.
clc, clear Nmea

empty = blanks(10);

% GGA - GPS Fixed Data
Nmea.gga.messageId = empty;
Nmea.gga.utcTime = empty;
Nmea.gga.latitude = empty;
Nmea.gga.northOrSouth = empty;
Nmea.gga.longitude = empty;
Nmea.gga.eastOrWest = empty;
Nmea.gga.positionFix = empty;
Nmea.gga.satellitesUsed = empty;
Nmea.gga.hdop = empty;
Nmea.gga.mslAltitude = empty;
Nmea.gga.unitsForAltitude = empty;
Nmea.gga.geoidSeparation = empty;
Nmea.gga.unitsForGeoid = empty;
Nmea.gga.ageOfDiffCorrection = empty;
Nmea.gga.diffRefStation = empty;
Nmea.gga.checksum = empty;

% GLL - Geographic Position (Latitude/Longitude)
Nmea.gll.messageID = empty;
Nmea.gll.latitude = empty;
Nmea.gll.northOrSouth = empty;
Nmea.gll.longitude = empty;
Nmea.gll.eastOrWest = empty;
Nmea.gll.utcTime = empty;
Nmea.gll.status = empty;
Nmea.gll.checksum = empty;

% GSA - GNSS DOP and Active Satellites
Nmea.gsa.messageID = empty;
Nmea.gsa.mode1 = empty;
Nmea.gsa.mode2 = empty;
nChannels = 12;
for iChannel = 1:nChannels
    thisField = sprintf('SatUsedCh%02d',iChannel);
    Nmea.gsa.(thisField) = empty;
end
Nmea.gsa.pdop = empty;
Nmea.gsa.hdop = empty;
Nmea.gsa.vdop = empty;
Nmea.gsa.checksum = empty;

% GSV - GNSS Satellites in View
Nmea.gsv.messageID = empty;
Nmea.gsv.nMessages = empty;
nChannels = 4;
for iChannel = 1:nChannels
    thisfield = sprintf('satellitesInViewCh%02d',iChannel);
    Nmea.gsv.(thisfield) = empty;
    thisfield = sprintf('satellitesIDCh%02d',iChannel);
    Nmea.gsv.(thisfield) = empty;
    thisfield = sprintf('elevationCh%02d',iChannel);
    Nmea.gsv.(thisfield) = empty;
    thisfield = sprintf('azimuth%02d',iChannel);
    Nmea.gsv.(thisfield) = empty;
    thisfield = sprintf('snrCh%02d',iChannel);
    Nmea.gsv.(thisfield) = empty;
end
Nmea.gsv.checksum = empty;

% RMC - Recommended Minimum Specific GNSS Data
Nmea.rmc.messageID = empty;
Nmea.rmc.utcTime = empty;
Nmea.rmc.status = empty;
Nmea.rmc.latitude = empty;
Nmea.rmc.northOrSouth = empty;
Nmea.rmc.longitude = empty;
Nmea.rmc.eastOrWest = empty;
Nmea.rmc.speedOverGround = empty;
Nmea.rmc.courseOverGround = empty;
Nmea.rmc.date = empty;
Nmea.rmc.magneticVariation = empty;
Nmea.rmc.magEastOrWest = empty;
Nmea.rmc.checksum = empty;

% VTG - Course Over Ground and Ground Speed
Nmea.vtg.messageID = empty;
Nmea.vtg.courseA = empty;
Nmea.vtg.referenceA = empty;
Nmea.vtg.courseB = empty;
Nmea.vtg.referenceB = empty;
Nmea.vtg.speedA = empty;
Nmea.vtg.unitsA = empty;
Nmea.vtg.speedB = empty;
Nmea.vtg.unitsB = empty;
Nmea.vtg.checksum = empty;

% ZDA - Time and Date
Nmea.zda.messageID = empty;
Nmea.zda.utcTime = empty;
Nmea.zda.day = empty;
Nmea.zda.month = empty;
Nmea.zda.year = empty;
Nmea.zda.localZoneHour = empty;
Nmea.zda.localZoneMinutes = empty;
Nmea.zda.checksum = empty;

