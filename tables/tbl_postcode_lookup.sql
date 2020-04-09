create table postcode_lookup (
    postcode_7 character varying (7),
    postcode_8 character varying (8),
    postcode character varying (10),
    date_of_introduction character varying (6),
    date_of_termination character varying (6),
    user_type integer,
    easting numeric,
    northing numeric,
    positional_quality_indicator integer,
    oa character varying (9),
    county character varying (9),
    county_electoral_division character varying (9),
    district character varying (9),
    ward character varying (9),
    health_area character varying (9),
    nhs_region character varying (9),
    country character varying (9),
    region character varying (9),
    parliamentary_constituency character varying (9),
    european_electoral_region character varying (9),
    learning_region character varying (9),
    travel_to_work_area character varying (9),
    primary_care_trust character varying (9),
    nuts character varying (9),
    park character varying (9),
    lsoa character varying (9),
    msoa character varying (9),
    workplace_zone character varying (9),
    clinical_commissioning_group character varying (9),
    built_up_area character varying (9),
    built_up_area_subdivision character varying (9),
    rural_urban_classification character varying (2),
    oa_classification character varying (3),
    latitude numeric,
    longitude numeric,
    local_enterprise_partnership_1 character varying (9),
    local_enterprise_partnership_2 character varying (9),
    police_force_area character varying (9),
    imd integer,
    cancer_alliance character varying (9),
    sustainability_transformation_partnership character (9),
    postcode_trimmed character varying (8),
    postcode_area character varying (8),
    postcode_district character varying (8),
    postcode_sector character varying (8),
    postcode_sector_trimmed character varying (8),
    terminated boolean,
    library_service character varying (9)
);

select AddGeometryColumn ('public', 'postcode_lookup', 'geom', 27700, 'POINT', 2);

create unique index idx_postcodelookup_postcode_lsoa_district_county_country on postcode_lookup (postcode, lsoa, district, county, country);
create index idx_postcodelookup_lsoa on postcode_lookup (lsoa);
create index idx_postcodelookup_district on postcode_lookup (district);
create index idx_postcodelookup_county on postcode_lookup (county);
create index idx_postcodelookup_country on postcode_lookup (country);
cluster postcode_lookup using idx_postcodelookup_postcode;
create index idx_postcodelookup_postcode_trimmed on postcode_lookup (postcode_trimmed);
create index idx_postcodelookup_postcode_area on postcode_lookup (postcode_area);
create index idx_postcodelookup_postcode_district on postcode_lookup (postcode_district);
create index idx_postcodelookup_postcode_sector on postcode_lookup (postcode_sector);
create index idx_postcodelookup_postcode_sector_trimmed_postcode_lsoa_term on postcode_lookup (postcode_sector_trimmed, postcode, lsoa, terminated);
create index idx_postcodelookup_term_postcode_sector_trimmed_lsoa_postcode on postcode_lookup (terminated, postcode_sector_trimmed, lsoa, postcode);
create index idx_postcodelookup_libraryservice on postcode_lookup (library_service);
