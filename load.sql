-- Load postcodes
-- pcd,pcd2,pcds,dointr,doterm,oscty,ced,oslaua,osward,parish,usertype,oseast1m,osnrth1m,osgrdind,oshlthau,nhser,ctry,rgn,streg,pcon,eer,teclec,ttwa,pct,itl,statsward,oa01,casward,npark,lsoa01,msoa01,ur01ind,oac01,oa11,lsoa11,msoa11,wz11,sicbl,bua11,buasd11,ru11ind,oac11,lat,long,lep1,lep2,pfa,imd,calncv,icb,oa21,lsoa21,msoa21
create table postcode_lookup_temp (
    postcode_7 character varying (7),
    postcode_8 character varying (8),
    postcode character varying (10),
    date_of_introduction character varying (6),
    date_of_termination character varying (6),
    county character varying (9),
    county_electoral_division character varying (9),
    district character varying (9),
    ward character varying (9),
    parish character varying (9),
    user_type integer,
    easting numeric,
    northing numeric,
    positional_quality_indicator integer,
    health_authority character varying (9),
    nhs_region character varying (9),
    country character varying (9),
    region character varying (9),
    standard_statistical_region character varying (1),
    parliamentary_constituency character varying (9),
    european_electoral_region character varying (9),
    local_learning_and_skills_council character varying (9),
    travel_to_work_area character varying (9),
    primary_care_trust character varying (9),
    international_territorial_level character varying (9),
    statistical_ward character varying (6),
    oa_01 character varying (10),
    census_area_statistics_ward character varying (6),
    national_park character varying (9),
    lsoa_01 character varying (9),
    msoa_01 character varying (9),
    urban_rural_indicator_01 character varying (2),
    oa_01_classification character varying (3),
    oa_11 character varying (9),
    lsoa_11 character varying (9),
    msoa_11 character varying (9),
    workplace_zone character varying (9),
    sub_icb_location character varying (9),
    built_up_area character varying (9),
    built_up_area_sub_division character varying (9),
    rural_urban_classification_11 character varying (2),
    oa_classification_11 character varying (9),
    latitude numeric,
    longitude numeric,
    local_enterprise_partnership_1 character varying (9),
    local_enterprise_partnership_2 character varying (9),
    police_force_area character varying (9),
    imd integer,
    cancer_alliance character varying (9),
    integrated_care_board character varying (9),
    oa_21 character varying (9),
    lsoa_21 character varying (9),
    msoa_21 character varying (9)
);
\copy postcode_lookup_temp from 'data/ons_postcode_directory.csv' csv header force null easting,northing,latitude,longitude,district,ward,county,region,country,date_of_termination;
insert into postcode_lookup(postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,county,county_electoral_division,district,ward,parish,user_type,easting,northing,positional_quality_indicator,health_authority,nhs_region,country,region,standard_statistical_region,parliamentary_constituency,european_electoral_region,local_learning_and_skills_council,travel_to_work_area,primary_care_trust,international_territorial_level,statistical_ward,oa_01,census_area_statistics_ward,national_park,lsoa_01,msoa_01,urban_rural_indicator_01,oa_01_classification,oa_11,lsoa_11,msoa_11,workplace_zone,sub_icb_location,built_up_area,built_up_area_sub_division,rural_urban_classification_11,oa_classification_11,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,integrated_care_board,oa_21,lsoa_21,msoa_21,postcode_trimmed,postcode_area,postcode_district,postcode_sector,postcode_sector_trimmed,terminated)
select postcode_7,postcode_8,postcode,date_of_introduction,date_of_termination,county,county_electoral_division,district,ward,parish,user_type,easting,northing,positional_quality_indicator,health_authority,nhs_region,country,region,standard_statistical_region,parliamentary_constituency,european_electoral_region,local_learning_and_skills_council,travel_to_work_area,primary_care_trust,international_territorial_level,statistical_ward,oa_01,census_area_statistics_ward,national_park,lsoa_01,msoa_01,urban_rural_indicator_01,oa_01_classification,oa_11,lsoa_11,msoa_11,workplace_zone,sub_icb_location,built_up_area,built_up_area_sub_division,rural_urban_classification_11,oa_classification_11,latitude,longitude,local_enterprise_partnership_1,local_enterprise_partnership_2,police_force_area,imd,cancer_alliance,integrated_care_board,oa_21,lsoa_21,msoa_21,
replace(postcode, ' ', ''),substring(postcode, '^[a-zA-Z][a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?'),substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'),replace(substring(postcode, '^[a-zA-Z]+\d\d?[a-zA-Z]?\s*\d+'), ' ', ''),(date_of_termination is not null)
from postcode_lookup_temp;
drop table postcode_lookup_temp;
update postcode_lookup set geom = st_setsrid(st_makepoint(easting, northing), 27700);

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


-- Load counties
-- WKT,FID,CTY23CD,CTY23NM,BNG_E,BNG_N,LONG,LAT,GlobalID,SHAPE_Leng,SHAPE_Area
create table counties_temp_bfc (
    WKT text,
    FID text,
    CTY23CD character (9),
    CTY23NM character varying(200),
    BNG_E float,
    BNG_N float,
    LONG float,
    LAT float,
    GlobalID text,
    SHAPE_Leng numeric,
    SHAPE_Area numeric
);
\copy counties_temp_bfc from 'data/county_bfc.csv' csv header;
insert into county_boundary(ctycd, ctynm, geom)
select CTY23CD, CTY23NM, st_geomfromtext(WKT, 27700)
from counties_temp_bfc;
drop table counties_temp_bfc;
update county_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);
-- And generalised geometry
create table counties_temp_bgc (
    WKT text,
    FID text,
    CTY23CD character (9),
    CTY23NM character varying(200),
    BNG_E float,
    BNG_N float,
    LONG float,
    LAT float,
    GlobalID text,
    SHAPE_Leng numeric,
    SHAPE_Area numeric
);
\copy counties_temp_bgc from 'data/county_bgc.csv' csv header;
update county_boundary set geom_generalised = 
    (select WKT from counties_temp_bgc where CTY23CD = county_boundary.ctycd);
drop table counties_temp_bgc;

-- Load districts
-- WKT,FID,LAD23CD,LAD23NM,LAD23NMW,BNG_E,BNG_N,LONG,LAT,GlobalID,SHAPE_Leng,SHAPE_Area
create table district_temp_bfc (
    WKT text,
    FID text,
    LAD23CD character (9),
    LAD23NM character varying(200),
    LAD23NMW character varying(200),
    BNG_E float,
    BNG_N float,
    LONG float,
    LAT float,
    GlobalID text,
    SHAPE_Leng numeric,
    SHAPE_Area numeric
);
\copy district_temp_bfc from 'data/district_bfc.csv' csv header;
insert into lad_boundary(ladcd, ladnm, geom)
select LAD23CD, LAD23NM, st_geomfromtext(WKT, 27700)
from district_temp_bfc;
drop table district_temp_bfc;
update lad_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);
create table district_temp_bgc (
    WKT text,
    FID text,
    LAD23CD character (9),
    LAD23NM character varying(200),
    LAD23NMW character varying(200),
    BNG_E float,
    BNG_N float,
    LONG float,
    LAT float,
    GlobalID text,
    SHAPE_Leng numeric,
    SHAPE_Area numeric
);
\copy district_temp_bgc from 'data/district_bgc.csv' csv header;
update lad_boundary set geom_generalised = 
    (select WKT from district_temp_bgc where LAD23CD = lad_boundary.ladcd);
drop table district_temp_bgc;

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


-- Load LSOAs
create table lsoas_temp_bfc (
    WKT text,
    LSOA21CD character (9),
    LSOA21NM text,
    LSOA21NMW text,
    BNG_E text,
    BNG_N text,
    LAT text,
    LONG text,
    GlobalID text
);
\copy lsoas_temp_bfc from 'data/lsoa_boundaries_bfc.csv' csv header;
insert into lsoa_boundary(lsoacd, lsoanm, geom)
select LSOA21CD, LSOA21NM, st_geomfromtext(WKT, 27700)
from lsoas_temp_bfc;
drop table lsoas_temp_bfc;
update lsoa_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);
create table lsoas_temp_bgc (
    WKT text,
    LSOA21CD character (9),
    LSOA21NM text,
    GlobalID text
);
\copy lsoas_temp_bgc from 'data/lsoa_boundaries_bgc.csv' csv header;
update lsoa_boundary set geom_generalised = 
    (select WKT from lsoas_temp_bgc where LSOA21CD = lsoa_boundary.lsoacd);
drop table lsoas_temp_bgc; 

-- Load LSOA population
\copy lsoa_population from 'data/lsoa_population.csv' csv header;

-- Load LSOA IMD
\copy lsoa_imd from 'data/lsoa_imd.csv' csv header;

-- Load LSOA WIMD
\copy lsoa_wimd from 'data/lsoa_wimd.csv' csv header;

-- Load LSOA Rural Urban Lookup
create table lsoa_rural_urban_temp (
    FID text,
    LSOA11CD text,
    LSOA11NM text,
    RUC11CD text,
    RUC11 text
);
\copy lsoa_rural_urban_temp from 'data/lsoa11_rural_urban_classification.csv' csv header;
insert into lsoa_rural_urban(lsoacd, rucd)
select LSOA11CD, RUC11CD
from lsoa_rural_urban_temp;
drop table lsoa_rural_urban_temp;

-- Load LSOA to UTLA Lookup
create table lsoa_to_upper_lookup_temp (
    LSOA21CD text,
    LSOA21NM text,
    LSOA21NMW text,
    UTLA23CD text,
    UTLA23NM text,
    UTLA23NMW text,
    ObjectId text
);
\copy lsoa_to_upper_lookup_temp from 'data/lsoa21_to_utla23.csv' csv header;
insert into lsoa_upper_lookup(lsoacd, utlacd)
select LSOA21CD, UTLA23CD
from lsoa_to_upper_lookup_temp;
drop table lsoa_to_upper_lookup_temp;

-- Load LSOA11 to LSOA21 Lookup
create table lsoa11_to_lsoa21_temp (
    ObjectId text,
    LSOA11CD text,
    LSOA11NM text,
    LSOA21CD text,
    LSOA21NM text,
    LAD22CD text,
    LAD22NM text,
    LAD22NMW text
);
\copy lsoa11_to_lsoa21_temp from 'data/lsoa11_to_lsoa21_to_lad.csv' csv header;
insert into lsoa11_lsoa21(lsoa11, lsoa21)
select distinct LSOA11CD, LSOA21CD
from lsoa11_to_lsoa21_temp;
drop table lsoa11_to_lsoa21_temp;

-- Load LSOA11 to LSOA21 Lookup
create table lsoa11_to_lsoa21_exact_temp (
    LSOA11CD text,
    LSOA11NM text,
    LSOA21CD text,
    LSOA21NM text,
    CHGIND text,
    LAD22CD text,
    LAD22NM text,
    LAD22NMW text,
    ObjectId text
);
\copy lsoa11_to_lsoa21_exact_temp from 'data/lsoa11_to_lsoa21_exact.csv' csv header;
insert into lsoa11_lsoa21_exact(lsoa11, lsoa21, changeindicator)
select distinct LSOA11CD, LSOA21CD,CHGIND
from lsoa11_to_lsoa21_exact_temp;
drop table lsoa11_to_lsoa21_exact_temp;

-- Load built up areas
create table buas_temp (
    gsscode character (9),
    name1_text text,
    name1_language text,
    name2_text text,
    name2_language text,
    areahectares numeric,
    geometry_area_m numeric,
    wkt text
);
\copy buas_temp from 'data/os_open_built_up_areas.csv' csv header;
insert into built_up_area_boundary(buacd, buanm, geom)
select gsscode, name1_text, st_geomfromtext(wkt, 27700)
from buas_temp;
drop table buas_temp;
update built_up_area_boundary set bbox = st_snaptogrid(st_envelope(st_transform(geom, 3857)), 1);


-- load oa to bua lookup table
create table oa_bua_staging (
    OA21CD text,
    BUA22CD text,
    BUA22NM text,
    BUA22NMW text,
    LAD22CD text,
    LAD22NM text,
    LAD22NMW text,
    RGN22CD text,
    RGN22NM text,
    RGN22NMW text,
    ObjectId text
);
\copy oa_bua_staging from 'data/oa21_bua.csv' csv header;
insert into oa_bua(oa, bua)
select OA21CD, BUA22CD
from oa_bua_staging;
drop table oa_bua_staging;


-- load oa11 to oa21 lookup table
create table oa11_to_oa21_staging (
    ObjectId text,
    OA11CD text,
    OA21CD text,
    CHNGIND text,
    LAD22CD text,
    LAD22NM text,
    LAD22NMW text
);
\copy oa11_to_oa21_staging from 'data/oa11_oa21.csv' csv header;
insert into oa11_oa21(oa11, oa21)
select OA11CD, OA21CD
from oa11_to_oa21_staging;
drop table oa11_to_oa21_staging;


-- load oa population data
create table oa_population_staging (
    date text,
    geography text,
    geography_code text,
    all_persons numeric,
    female numeric,
    male numeric
);
\copy oa_population_staging from 'data/oa21_population.csv' csv header quote '"';
insert into oa_population(oa, population)
select geography_code, all_persons
from oa_population_staging;
drop table oa_population_staging;


-- load oa11 to lsoa11 lookup table
create table oa11_to_lsoa11_staging (
    OA11CD text,
    LSOA11CD text,
    LSOA11NM text,
    MSOA11CD text,
    MSOA11NM text,
    LAD11CD text,
    LAD11NM text,
    LAD11NMW text,
    ObjectId text
);
\copy oa11_to_lsoa11_staging from 'data/oa11_lsoa11.csv' csv header;
insert into oa11_lsoa11(oa11, lsoa11)
select OA11CD, LSOA11CD
from oa11_to_lsoa11_staging;
drop table oa11_to_lsoa11_staging;

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
  "region"
from staging_local_authority where "gss-code" is not null;

drop table staging_local_authority;


-- create staging table for open names
create table staging_place_names (
  ID text,--osgb4000000074541653
  NAMES_URI text,--http://data.ordnancesurvey.co.uk/id/4000000074541653
  NAME1 text,--Westing
  NAME1_LANG text,
  NAME2 text,
  NAME2_LANG text,
  "TYPE" text,--populatedPlace
  LOCAL_TYPE text,--Other Settlement
  GEOMETRY_X integer,--457077
  GEOMETRY_Y integer,--1205289
  MOST_DETAIL_VIEW_RES integer,--15000
  LEAST_DETAIL_VIEW_RES integer,--25000
  MBR_XMIN integer,
  MBR_YMIN integer,
  MBR_XMAX integer,
  MBR_YMAX integer,
  POSTCODE_DISTRICT text,
  POSTCODE_DISTRICT_URI text,
  POPULATED_PLACE text,
  POPULATED_PLACE_URI text,
  POPULATED_PLACE_TYPE text,
  DISTRICT_BOROUGH text,
  DISTRICT_BOROUGH_URI text,
  DISTRICT_BOROUGH_TYPE text,
  COUNTY_UNITARY text,
  COUNTY_UNITARY_URI text,
  COUNTY_UNITARY_TYPE text,
  REGION text,
  REGION_URI text,
  COUNTRY text,
  COUNTRY_URI text,
  RELATED_SPATIAL_OBJECT text,
  SAME_AS_DBPEDIA text,
  SAME_AS_GEONAMES text
);

-- load open names csv
\copy staging_place_names from 'data/os_open_names.csv' csv header;

-- insert into place_name table
insert into place_name (uri, name1, name1_lang, name2, name2_lang, inspire_type, local_type, easting, northing, most_detail_view_resolution, least_detail_view_resolution, bbox_xmin, bbox_ymin, bbox_xmax, bbox_ymax, postcode_district, populated_place, district_code, county_unitary_code, region_code, country_code, same_as_dbpedia, same_as_geonames, geom)
select
  NAMES_URI,
  NAME1,
  NAME1_LANG,
  NAME2,
  NAME2_LANG,
  "TYPE",
  LOCAL_TYPE,
  GEOMETRY_X,
  GEOMETRY_Y,
  MOST_DETAIL_VIEW_RES,
  LEAST_DETAIL_VIEW_RES,
  MBR_XMIN,
  MBR_YMIN,
  MBR_XMAX,
  MBR_YMAX,
  POSTCODE_DISTRICT,
  POPULATED_PLACE,
  l.ladcd,
  cty.ctycd,
  r.rgncd,
  c.ctrycd,
  SAME_AS_DBPEDIA,
  SAME_AS_GEONAMES,
  st_setsrid(st_makepoint(GEOMETRY_X::numeric, GEOMETRY_Y::numeric), 27700)
from staging_place_names sp
left join lad_boundary l on l.ladnm = sp.DISTRICT_BOROUGH
left join county_boundary cty on cty.ctynm = sp.COUNTY_UNITARY
left join region_boundary r on r.rgnnm = sp.REGION
left join country_boundary c on c.ctrynm = sp.COUNTRY;

-- Pre-generate MVT 
insert into generated_mvt_type(type)
values 
    ('library_authority_boundaries'),
    ('lsoa_boundaries'),
    ('built_up_areas');

select fn_generate_mvt('fn_library_authorities_mvt', 0, 8);
select fn_generate_mvt('fn_lsoas_mvt', 0, 8);
select fn_generate_mvt('fn_built_up_areas_mvt', 0, 8);
