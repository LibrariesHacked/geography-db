create table place_name (
  id serial primary key,
  uri text,
  name1 text,
  name1_lang text,
  name2 text,
  name2_lang text,
  inspire_type text,
  local_type text,
  easting integer,
  northing integer,
  most_detail_view_resolution integer,
  least_detail_view_resolution integer,	
  bbox_xmin integer,
  bbox_ymin integer,
  bbox_xmax integer,
  bbox_ymax integer,
  postcode_district text,
  populated_place text,
  district_code text,
  county_unitary_code text,
  region_code text,
  country_code text,
  same_as_dbpedia text,
  same_as_geonames text
);

select AddGeometryColumn ('public', 'place_name', 'geom', 27700, 'POINT', 2);
create index idx_place_name_geom on place_name using gist (geom);

create index idx_place_name_uri on place_name (uri);
create index idx_place_name_name1 on place_name (name1);
create index idx_place_name_name1_trgm on place_name using gin (name1 gin_trgm_ops);
create index idx_place_name_name2 on place_name (name2);
create index idx_place_name_name2_trgm on place_name using gin (name2 gin_trgm_ops);
create index idx_place_name_postcode_district on place_name (postcode_district);
create index idx_place_name_district_code on place_name (district_code);
create index idx_place_name_county_unitary_code on place_name (county_unitary_code);
create index idx_place_name_region_code on place_name (region_code);
create index idx_place_name_country_code on place_name (country_code);
