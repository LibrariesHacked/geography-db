-- Load postcodes
create table postcode_lookup_temp (
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
    sustainability_transformation_partnership character (9)
);
\copy postcode_lookup_temp from 'data/national_statistics_postcode_lookup.csv' csv header force null easting,northing,latitude,longitude,lsoa,district,ward,county,region,country,date_of_termination;
insert into postcode_lookup(postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,user_type,easting,northing,positional_quality_indicator,oa,county,county_electoral_division,district,ward,health_area,nhs_region,country,region,parliamentary_constituency,european_electoral_region,learning_region,travel_to_work_area,primary_care_trust,nuts,park,lsoa,msoa,workplace_zone,clinical_commissioning_group,built_up_area,built_up_area_subdivision,rural_urban_classification,oa_classification,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,sustainability_transformation_partnership,postcode_trimmed,postcode_area,postcode_district,postcode_sector,postcode_sector_trimmed,terminated)
select postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,user_type,easting,northing,positional_quality_indicator,oa,county,county_electoral_division,district,ward,health_area,nhs_region,country,region,parliamentary_constituency,european_electoral_region,learning_region,travel_to_work_area,primary_care_trust,nuts,park,lsoa,msoa,workplace_zone,clinical_commissioning_group,built_up_area,built_up_area_subdivision,rural_urban_classification,oa_classification,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,sustainability_transformation_partnership,
replace(postcode, ' ', ''),substring(postcode, '^[a-zA-Z][a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'),replace(substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'), ' ', ''),(date_of_termination is not null)
from postcode_lookup_temp;
drop table postcode_lookup_temp;

-- Load counties
create table counties_temp (
    WKT text,
    NAME text,
    AREA_CODE text,
    DESCRIPTIO text,
    FILE_NAME text,
    NUMBER numeric,
    NUMBER0 numeric,
    POLYGON_ID numeric,
    UNIT_ID numeric,
    CODE character (9),
    HECTARES float,
    AREA float,
    TYPE_CODE text,
    DESCRIPT0 text,
    TYPE_COD0 text,
    DESCRIPT1 text
);
\copy counties_temp from 'data/county_region.csv' csv header;
insert into county_boundary(ctycd, ctynm, geom)
select CODE, NAME, st_geomfromtext(WKT, 27700)
from counties_temp;
drop table counties_temp;
update county_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load countries
create table countries_temp (
    WKT text,
    CTRY22CD character (9),
    CTRY22NM text,
    CTRY22NMW text,
    BNG_E numeric,
    BNG_N numeric,
    LONG float,
    LAT float
);
\copy countries_temp from 'data/country_boundaries.csv' csv header;
insert into country_boundary(ctrycd, ctrynm, ctrynmw, geom)
select CTRY22CD, CTRY22NM, CTRY22NMW, st_geomfromtext(WKT, 27700)
from countries_temp;
drop table countries_temp;
update country_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load LADs
create table lads_temp (
    WKT text,
    NAME text,
    AREA_CODE text,
    DESCRIPTIO text,
    FILE_NAME text,
    NUMBER numeric,
    NUMBER0 numeric,
    POLYGON_ID numeric,
    UNIT_ID numeric,
    CODE character (9),
    HECTARES float,
    AREA float,
    TYPE_CODE text,
    DESCRIPT0 text,
    TYPE_COD0 text,
    DESCRIPT1 text
);
\copy lads_temp from 'data/district_borough_unitary_region.csv' csv header;
insert into lad_boundary(ladcd, ladnm, geom)
select CODE, NAME, st_geomfromtext(WKT, 27700)
from lads_temp;
drop table lads_temp;
update lad_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load LSOAs
create table lsoas_temp (
    WKT text,
    LSOA21CD character (9),
    LSOA21NM text,
    GlobalID text
);
\copy lsoas_temp from 'data/lsoa_boundaries.csv' csv header;
insert into lsoa_boundary(lsoacd, lsoanm, geom)
select LSOA21CD, LSOA21NM, st_geomfromtext(WKT, 27700)
from lsoas_temp;
drop table lsoas_temp;
update lsoa_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load LSOA population
\copy lsoa_population from 'data/lsoa_population.csv' csv header;

-- Load LSOA IMD
\copy lsoa_imd from 'data/lsoa_imd.csv' csv header;

-- Load LSOA WIMD
\copy lsoa_wimd from 'data/lsoa_wimd.csv' csv header;

-- Load Data zones
create table datazones_temp (
    WKT text,
    DataZone character (9),
    Name character varying (200),
    TotPop2011 integer,
    ResPop2011 integer,
    HHCnt2011 integer,
    StdAreaHa numeric,
    StdAreaKm2 numeric,
    Shape_Leng numeric,
    Shape_Area numeric
);
\copy datazones_temp from 'data/datazone_boundaries.csv' csv header;
insert into datazone_boundary(datazone, name, totpop2011, respop2011, hhcnt2011, stdareaha, stdareakm2, shape_leng, shape_area, geom)
select datazone, name, totpop2011, respop2011, hhcnt2011, stdareaha, stdareakm2, shape_leng, shape_area, st_geomfromtext(WKT, 27700)
from datazones_temp;
drop table datazones_temp;
update datazone_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load datazone IMD and population (it is from the same source)
\copy datazone_imd_population from 'data/datazone_imd_population.csv' csv header;

-- Load NI SOAs
create table ni_sa_temp (
    WKT text,
    SA2011 character (9),
    SOA2011 character (10),
    X_COORD numeric,
    Y_COORD numeric,
    Hectares numeric
);
\copy ni_sa_temp from 'data/ni_sa_boundaries.csv' csv header;
insert into ni_sa_boundary(sa_code, soa_code, geom)
select SA2011, SOA2011, st_geomfromtext(WKT, 29902)
from ni_sa_temp;
drop table ni_sa_temp;
update ni_sa_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load NI SA IMD
create table ni_sa_imd_temp (
  sa_code character varying(9),
  imd_rank integer,
  income_rank integer,
  employment_rank integer,
  health_rank integer,
  education_rank integer,
  services_rank integer,
  environment_rank integer,
  crime_rank integer
);
\copy ni_sa_imd_temp from 'data/ni_imd.csv' csv header;
insert into ni_sa_imd(sa_code, imd_decile, imd_rank, income_rank, employment_rank, health_rank, education_rank, services_rank, environment_rank, crime_rank)
select sa_code, ntile(10) over (order by imd_rank asc), imd_rank, income_rank, employment_rank, health_rank, education_rank, services_rank, environment_rank, crime_rank
from ni_sa_imd_temp;
drop table ni_sa_imd_temp;

-- Load NI SA Population
\copy ni_sa_population from 'data/ni_population.csv' csv header;

-- Load regions
create table regions_temp (
    WKT text,
    objectid text,
    rgn18cd character (9),
    rgn18nm character varying(200),
    bng_e float,
    bng_n float,
    long float,
    lat float,
    st_areasha numeric,
    st_lengths numeric
);
\copy regions_temp from 'data/region_boundaries.csv' csv header;
insert into region_boundary(rgncd, rgnnm, geom)
select rgn18cd, rgn18nm, st_geomfromtext(WKT, 27700)
from regions_temp;
drop table regions_temp;

-- Load wards
create table wards_temp (
    WKT text,
    NAME text,
    AREA_CODE text,
    DESCRIPTIO text,
    FILE_NAME text,
    NUMBER numeric,
    NUMBER0 numeric,
    POLYGON_ID numeric,
    UNIT_ID numeric,
    CODE character (9),
    HECTARES float,
    AREA float,
    TYPE_CODE text,
    DESCRIPT0 text,
    TYPE_COD0 text,
    DESCRIPT1 text
);
\copy wards_temp from 'data/district_borough_unitary_ward_region.csv' csv header;
insert into ward_boundary(wdcd, wdnm, geom)
select CODE, NAME, st_geomfromtext(WKT, 27700)
from wards_temp where TYPE_CODE != 'VA';
drop table wards_temp;

-- upper lower tier lookups
create table lower_upper_lookup_temp (
    LTLA23CD character (9),
    LTLA23NM text,
    LTLA23NMW text,
    UTLA23CD character (9),
    UTLA23NM text,
    UTLA23NMW text,
    ObjectId text
);
\copy lower_upper_lookup_temp from 'data/lower_upper_lookup.csv' csv header;
insert into lower_upper_lookup(ltlacd, utlacd)
select LTLA23CD, UTLA23CD
from lower_upper_lookup_temp;
drop table lower_upper_lookup_temp;

-- Northern Ireland library service
update postcode_lookup p
set library_service = 'N92000002'
where p.country = 'N92000002';

-- England county library services 
update postcode_lookup p
set library_service = lu.utlacd
from lower_upper_lookup lu
where lu.utlacd = p.county
and p.country = 'E92000001';

-- England and Wales district library Services
update postcode_lookup p
set library_service = lu.utlacd
from lower_upper_lookup lu
where lu.utlacd = p.district
and p.country in ('E92000001', 'W92000004');

-- Scotland district library services
update postcode_lookup p
set library_service = lb.ladcd
from lad_boundary lb
where lb.ladcd = p.district
and p.country = 'S92000003';

-- Pre-generate MVT 
insert into generated_mvt_type(type)
values 
    ('library_authority_boundaries'),
    ('lsoa_boundaries');

-- Local authorities
create table staging_local_authority (
  "local-authority-code" text,
  "official-name" text,
  "nice-name" text,
  "gss-code" text,
  "start-date" text,
  "end-date" text,
  "replaced-by" text,
  "nation" text,
  "region" text,
  "local-authority-type" text,
  "local-authority-type-name" text,
  "county-la" text,
  "combined-authority" text,
  "alt-names" text,
  "former-gss-codes" text,
  "notes" text,
  "current-authority" text,
  "BS-6879" text,
  "ecode" text,
  "even-older-register-and-code" text,
  "gov-uk-slug" text,
  "area" text,
  "pop-2020" text,
  "x" text,
  "y" text,
  "long" text,
  "lat" text,
  "powers" text,
  "lower_or_unitary" text,
  "mapit-area-code" text,
  "ofcom" text,
  "old-ons-la-code" text,
  "old-register-and-code" text,
  "open-council-data-id" text,
  "os-file" text,
  "os" text,
  "snac" text,
  "wdtk-id" text
);
\copy staging_local_authority from 'data/uk_local_authorities.csv' csv header;

insert into administrative_names (code, name, nice_name, nation, region)
select
  "gss-code",
  "official-name",
  "nice-name",
  "nation",
  "region" from staging_local_authority where "gss-code" is not null;

drop table staging_local_authority;

select fn_generate_mvt('fn_library_authorities_mvt', 0, 10);
select fn_generate_mvt('fn_lsoas_mvt', 0, 10);
