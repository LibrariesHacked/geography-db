-- create the database
\i 'database/db_geography.sql';

-- switch to using the database
\c geography_test;

-- setup any extensions
\i 'database/db_extensions.sql';

-- set client encoding
set client_encoding = 'UTF8';

-- create tables
\i 'tables/tbl_county_boundary.sql';
\i 'tables/tbl_lad_boundary.sql';
\i 'tables/tbl_lsoa_boundary.sql';
\i 'tables/tbl_postcode_lookup.sql';

-- load in data
\i 'load.sql';

-- create views
\i 'views/vw_county_boundaries.sql';
\i 'views/vw_lad_boundaries.sql';
\i 'views/vw_lsoa_boundaries.sql';
\i 'views/vw_postcodes.sql';

-- create functions
\i 'functions/fn_counties_mvt.sql';
\i 'functions/fn_lads_mvt.sql';
\i 'functions/fn_lsoas_mvt.sql';
\i 'functions/fn_postcodelsoasfromsectors.sql';

vacuum analyze;