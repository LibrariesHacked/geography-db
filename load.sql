
-- import postcode_lookup
\copy postcode_lookups from 'data/postcode_lookups.csv' csv header force null easting,northing,latitude,longitude;

vacuum analyze;