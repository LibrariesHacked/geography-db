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
\copy postcode_lookup_temp from 'data/postcode_lookup.csv' csv header force null easting,northing,latitude,longitude,lsoa,district,ward,county,region,country,date_of_termination;
insert into postcode_lookup(postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,user_type,easting,northing,positional_quality_indicator,oa,county,county_electoral_division,district,ward,health_area,nhs_region,country,region,parliamentary_constituency,european_electoral_region,learning_region,travel_to_work_area,primary_care_trust,nuts,park,lsoa,msoa,workplace_zone,clinical_commissioning_group,built_up_area,built_up_area_subdivision,rural_urban_classification,oa_classification,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,sustainability_transformation_partnership,postcode_trimmed,postcode_area,postcode_district,postcode_sector,postcode_sector_trimmed,terminated)
select postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,user_type,easting,northing,positional_quality_indicator,oa,county,county_electoral_division,district,ward,health_area,nhs_region,country,region,parliamentary_constituency,european_electoral_region,learning_region,travel_to_work_area,primary_care_trust,nuts,park,lsoa,msoa,workplace_zone,clinical_commissioning_group,built_up_area,built_up_area_subdivision,rural_urban_classification,oa_classification,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,sustainability_transformation_partnership,
replace(postcode, ' ', ''),substring(postcode, '^[a-zA-Z][a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'),replace(substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'), ' ', ''),(date_of_termination is not null)
from postcode_lookup_temp;
drop table postcode_lookup_temp;

-- Load counties
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
update county_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load countries
create table countries_temp (
    WKT text,
    objectid text,
    ctry18cd character (9),
    ctry18nm character varying(200),
    ctry18nmw character varying(200),
    bng_e float,
    bng_n float,
    long float,
    lat float,
    st_areasha numeric,
    st_lengths numeric
);
\copy countries_temp from 'data/country_boundaries.csv' csv header;
insert into country_boundary(ctry18cd, ctry18nm, ctry18nmw, st_areasha, st_lengths, geom)
select ctry18cd, ctry18nm, ctry18nmw, st_areasha, st_lengths, st_geomfromtext(WKT, 27700)
from countries_temp;
drop table countries_temp;
update country_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

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
update lad_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);

-- Load LSOAs
create table lsoas_temp ( -- WKT,OBJECTID,LSOA11CD,LSOA11NM,BNG_E,BNG_N,LONG_,LAT,Shape_Leng,Shape__Are,Shape__Len
    WKT text,
    objectid text,
    lsoa11cd character (9),
    lsoa11nm character varying(200),
    bng_e numeric,
    bng_n numeric,
    long_ numeric,
    lat numeric,
    shape_leng numeric,
    shape__are numeric,
    shape__len numeric
);
\copy lsoas_temp from 'data/lsoa_boundaries.csv' csv header;
insert into lsoa_boundary(lsoa11cd, lsoa11nm, st_areasha, st_lengths, geom)
select lsoa11cd, lsoa11nm, shape__are, shape__len, st_geomfromtext(WKT, 27700)
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
insert into region_boundary(rgn18cd, rgn18nm, st_areasha, st_lengths, geom)
select rgn18cd, rgn18nm, st_areasha, st_lengths, st_geomfromtext(WKT, 27700)
from regions_temp;
drop table regions_temp;

-- Load wards
create table wards_temp (
    WKT text,
    objectid text,
    wd19cd character (9),
    wd19nm character varying(200),
    wd19nmw character varying(200),
    bng_e float,
    bng_n float,
    long float,
    lat float,
    st_areasha numeric,
    st_lengths numeric
);
\copy wards_temp from 'data/ward_boundaries.csv' csv header;
insert into ward_boundary(wd19cd, wd19nm, wd19nmw, st_areasha, st_lengths, geom)
select wd19cd, wd19nm, wd19nmw, st_areasha, st_lengths, st_geomfromtext(WKT, 27700)
from wards_temp;
drop table wards_temp;

-- administrative lookups
create table administrative_lookup_temp (
    wd19cd character (9),
    wd19nm character varying (200),
    lad19cd character (9),
    lad19nm character varying (200),
    cty19cd character (9),
    cty19nm character varying (200),
    rgn19cd character (9),
    rgn19nm character varying (200),
    ctry19cd character (9),
    ctry19nm character varying (200),
    fid integer
);
\copy administrative_lookup_temp from 'data/administrative_lookup.csv' csv header;
insert into administrative_lookup(wd19cd, lad19cd, cty19cd, rgn19cd, ctry19cd)
select wd19cd, lad19cd, cty19cd, rgn19cd, ctry19cd
from administrative_lookup_temp;
drop table administrative_lookup_temp;

-- upper lower tier lookups
create table lower_upper_lookup_temp ( -- LTLA19CD,LTLA19NM,UTLA19CD,UTLA19NM,FID
    ltla19cd character (9),
    ltla19nm character varying (200),
    utla19cd character (9),
    utla19nm character varying (200),
    fid integer
);
\copy lower_upper_lookup_temp from 'data/lower_upper_lookup.csv' csv header;
insert into lower_upper_lookup(ltla19cd, utla19cd)
select ltla19cd, utla19cd
from lower_upper_lookup_temp;
drop table lower_upper_lookup_temp;

-- Northern Ireland library service
update postcode_lookup p
set library_service = 'N92000002'
where p.country = 'N92000002';

-- England county library services 
update postcode_lookup p
set library_service = lu.utla19cd
from lower_upper_lookup lu
where lu.utla19cd = p.county
and p.country = 'E92000001';

-- England and Wales district library Services
update postcode_lookup p
set library_service = lu.utla19cd
from lower_upper_lookup lu
where lu.utla19cd = p.district
and p.country in ('E92000001', 'W92000004');

-- Scotland district library services
update postcode_lookup p
set library_service = lb.lad19cd
from lad_boundary lb
where lb.lad19cd = p.district
and p.country = 'S92000003';


-- Pre-generate MVT 
insert into generated_mvt_type(type)
values 
    ('library_authority_boundaries'),
    ('lsoa_boundaries');

select fn_generate_mvt('fn_library_authorities_mvt', 0, 12);
select fn_generate_mvt('fn_lsoas_mvt', 0, 12);