
-- import postcode_lookup
\copy postcode_lookup from 'data/postcode_lookup.csv' csv header force null easting,northing,latitude,longitude;

-- add columns for postcode lookup
alter table postcode_lookup add column postcode_trimmed character varying (8);
alter table postcode_lookup add column postcode_area character varying (8);
alter table postcode_lookup add column postcode_district character varying (8);
alter table postcode_lookup add column postcode_sector character varying (8);
alter table postcode_lookup add column postcode_sector_trimmed character varying (8);

select AddGeometryColumn ('public', 'postcode_lookup', 'geom', 27700, 'POINT', 2);

update postcode_lookup
set 
    postcode_trimmed = replace(postcode, ' ', ''),
    postcode_area = substring(postcode, '^[a-zA-Z][a-zA-Z]?'),
    postcode_district = substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?'),
    postcode_sector = substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'),
    postcode_sector_trimmed = replace(substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'), ' ', ''),
    geom = st_setsrid(st_makepoint(easting, northing), 27700);

-- add indexes for new columns
create index idx_postcodelookup_postcode_trimmed on postcode_lookup (postcode_trimmed);
create index idx_postcodelookup_postcode_area on postcode_lookup (postcode_area);
create index idx_postcodelookup_postcode_district on postcode_lookup (postcode_district);
create index idx_postcodelookup_postcode_sector on postcode_lookup (postcode_sector);
create index idx_postcodelookup_postcode_sector_trimmed on postcode_lookup (postcode_sector_trimmed);

vacuum analyze;