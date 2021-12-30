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
\i 'tables/tbl_country_boundary.sql';
\i 'tables/tbl_lad_boundary.sql';
\i 'tables/tbl_lsoa_boundary.sql';
\i 'tables/tbl_lsoa_population.sql';
\i 'tables/tbl_lsoa_imd.sql';
\i 'tables/tbl_lsoa_wimd.sql';
\i 'tables/tbl_datazone_boundary.sql';
\i 'tables/tbl_datazone_imd_population.sql';
\i 'tables/tbl_ni_sa_boundary.sql';
\i 'tables/tbl_ni_sa_imd.sql';
\i 'tables/tbl_ni_sa_population.sql';
\i 'tables/tbl_region_boundary.sql';
\i 'tables/tbl_ward_boundary.sql';
\i 'tables/tbl_postcode_lookup.sql';
\i 'tables/tbl_administrative_lookup.sql';
\i 'tables/tbl_administrative_names.sql';
\i 'tables/tbl_lower_upper_lookup.sql';
\i 'tables/tbl_generated_mvt_type.sql';
\i 'tables/tbl_generated_mvt.sql';

-- create views
\i 'views/vw_county_boundaries.sql';
\i 'views/vw_country_boundaries.sql';
\i 'views/vw_lad_boundaries.sql';
\i 'views/vw_lsoa_boundaries.sql';
\i 'views/vw_lsoa.sql';
\i 'views/vw_region_boundaries.sql';
\i 'views/vw_ward_boundaries.sql';
\i 'views/vw_library_boundaries.sql';
\i 'views/vw_postcodes.sql';
\i 'views/vw_smallareas_uk.sql';
\i 'views/vw_postcode_smallarea_uk.sql';

-- create functions
\i 'functions/fn_bbox.sql';
\i 'functions/fn_counties_mvt.sql';
\i 'functions/fn_countries_mvt.sql';
\i 'functions/fn_lads_mvt.sql';
\i 'functions/fn_library_authorities_mvt.sql';
\i 'functions/fn_lsoas_mvt.sql';
\i 'functions/fn_regions_mvt.sql';
\i 'functions/fn_wards_mvt.sql';
\i 'functions/fn_postcodelsoasfromsectors.sql';
\i 'functions/fn_generate_mvt.sql';

-- load in data
\i 'load.sql';

vacuum analyze;