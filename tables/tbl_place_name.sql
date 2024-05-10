create table place_name (
  id,
  uri,
  name1,
  name1_lang,
  name2,
  name2_lang,
  inspire_type,
  local_type,
  easting,
  northing,
  most_detail_view_resolution,
  least_detail_view_resolution,	
  bbox_xmin,
  bbox_ymin,
  bbox_xmax,
  bbox_ymax,
  postcode_district,
  populated_place,
  district_id,
  county_unitary_id,
  region_id,
  country_id,
  same_as_dbpedia,
  same_as_geonames
);

select AddGeometryColumn ('public', 'place_name', 'geom', 27700, 'POINT', 2);
create index idx_place_name_geom on place_name using gist (geom);

create index idx_place_name_name1 on place_name (name1);
create index idx_place_name_name1_trgm on place_name using gin (name1 gin_trgm_ops);
create index idx_place_name_name2 on place_name (name2);
create index idx_place_name_name2_trgm on place_name using gin (name2 gin_trgm_ops);
create index idx_place_name_postcode_district on place_name (postcode_district);
create index idx_place_name_district_id on place_name (district_id);
create index idx_place_name_county_unitary_id on place_name (county_unitary_id);
create index idx_place_name_region_id on place_name (region_id);
create index idx_place_name_country_id on place_name (country_id);


ID,NAMES_URI,NAME1,NAME1_LANG,NAME2,NAME2_LANG,TYPE,LOCAL_TYPE,
  GEOMETRY_X,
  GEOMETRY_Y,
  MOST_DETAIL_VIEW_RES,
  LEAST_DETAIL_VIEW_RES	MBR_XMIN,
  MBR_YMIN,
  MBR_XMAX,
  MBR_YMAX,
  POSTCODE_DISTRICT,
  POSTCODE_DISTRICT_URI,
  POPULATED_PLACE,
  POPULATED_PLACE_URI,
  POPULATED_PLACE_TYPE,
  DISTRICT_BOROUGH,
  DISTRICT_BOROUGH_URI,
  DISTRICT_BOROUGH_TYPE,
  COUNTY_UNITARY,
  COUNTY_UNITARY_URI,
  COUNTY_UNITARY_TYPE,
  REGION,
  REGION_URI,
  COUNTRY,
  COUNTRY_URI,
  RELATED_SPATIAL_OBJECT,
  SAME_AS_DBPEDIA,
  SAME_AS_GEONAMES