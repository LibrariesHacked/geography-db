-- import postcode_lookup
\copy postcode_lookup from 'data/postcode_lookup.csv' csv header force null easting,northing,latitude,longitude;

-- add columns for postcode lookup
alter table postcode_lookup add column postcode_trimmed character varying (8);
alter table postcode_lookup add column postcode_area character varying (8);
alter table postcode_lookup add column postcode_district character varying (8);
alter table postcode_lookup add column postcode_sector character varying (8);
alter table postcode_lookup add column postcode_sector_trimmed character varying (8);
alter table postcode_lookup add column terminated boolean;

select AddGeometryColumn ('public', 'postcode_lookup', 'geom', 27700, 'POINT', 2);

-- Set nulls instead of empty strings
update postcode_lookup set lsoa = null where lsoa = '';
update postcode_lookup set date_of_termination = null where date_of_termination = '';

update postcode_lookup
set 
    postcode_trimmed = replace(postcode, ' ', ''),
    postcode_area = substring(postcode, '^[a-zA-Z][a-zA-Z]?'),
    postcode_district = substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?'),
    postcode_sector = substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'),
    postcode_sector_trimmed = replace(substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'), ' ', ''),
    geom = st_setsrid(st_makepoint(easting, northing), 27700),
    terminated = (date_of_termination is not null);

-- add indexes for new columns
create index idx_postcodelookup_postcode_trimmed on postcode_lookup (postcode_trimmed);
create index idx_postcodelookup_postcode_area on postcode_lookup (postcode_area);
create index idx_postcodelookup_postcode_district on postcode_lookup (postcode_district);
create index idx_postcodelookup_postcode_sector on postcode_lookup (postcode_sector);
create index idx_postcodelookup_postcode_sector_trimmed_postcode_lsoa_term on postcode_lookup (postcode_sector_trimmed, postcode, lsoa, terminated);
create index idx_postcodelookup_term_postcode_sector_trimmed_lsoa_postcode on postcode_lookup (terminated, postcode_sector_trimmed, lsoa, postcode);

-- Load LSOAs
create table lsoas_temp (
    WKT text,
    objectid text,
    lsoa11cd character (9),
    lsoa11nm character varying(200),
    lsoa11nmw character varying(200),
    st_areasha numeric,
    st_lengths numeric
);
\copy lsoas_temp from 'data/lsoa_boundaries.csv' csv header;
insert into lsoa_boundary(lsoa11cd, lsoa11nm, lsoa11nmw, st_areasha, st_lengths, geom)
select lsoa11cd, lsoa11nm, lsoa11nmw, st_areasha, st_lengths, st_transform(st_geomfromtext(WKT, 4326), 27700)
from lsoas_temp;
drop table lsoas_temp;

-- Load Counties
create table counties_temp (
    WKT text,
    objectid text,
    cty19cd character (9),
    cty19nm character varying(200),
    bng_e float,
    bng_n float,
    long float,
    lat float,
    st_areasha numeric,
    st_lengths numeric
);
\copy counties_temp from 'data/county_boundaries.csv' csv header;
insert into county_boundary(cty19cd, cty19nm, st_areasha, st_lengths, geom)
select cty19cd, cty19nm, st_areasha, st_lengths, st_geomfromtext(WKT, 27700)
from counties_temp;
drop table counties_temp;

-- Load LADs
create table lads_temp (
    WKT text,
    objectid text,
    lad19cd character (9),
    lad19nm character varying(200),
    lad19nmw character varying(200),
    bng_e float,
    bng_n float,
    long float,
    lat float,
    st_areasha numeric,
    st_lengths numeric
);
\copy lads_temp from 'data/lad_boundaries.csv' csv header;
insert into lad_boundary(lad19cd, lad19nm, lad19nmw, st_areasha, st_lengths, geom)
select lad19cd, lad19nm, lad19nmw, st_areasha, st_lengths, st_geomfromtext(WKT, 27700)
from lads_temp;
drop table lads_temp;
