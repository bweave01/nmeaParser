% INITIALIZE_NMEA_DATA Sets up the data structures
clc, clear gga

% GGA
empty = char(1:10);
gga.msg_id = empty;
gga.utc_time = empty;
gga.latitude = empty;
gga.n_s_indic = empty;
gga.longitude = empty;
gga.e_w_indic = empty;
gga.pos_fix = empty;
gga.sats_used = empty;
gga.hdop = empty;
gga.msl_altitude = empty;
gga.units_alt = empty;
gga.geoid_separation = empty;
gga.units_geoid = empty;
gga.age_diff_corr = empty;
gga.diff_ref_station = empty;
gga.checksum = empty;
