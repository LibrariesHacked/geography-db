-- create the database
\i 'database/db_geography.sql';

-- switch to using the database
\c geography;

-- setup any extensions
\i 'database/db_extensions.sql';

-- set client encoding
set client_encoding = 'UTF8';

-- create tables
\i 'tables/tbl_postcode_lookup.sql';
\i 'tables/tbl_lsoa_boundary.sql';

-- load in data
\i 'load.sql';

-- create views
\i 'views/vw_postcodes.sql';

-- create functions
\i 'functions/fn_postcodelsoasfromsectors.sql';

vacuum analyze;