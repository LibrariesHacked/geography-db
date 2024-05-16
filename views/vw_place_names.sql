create view vw_place_names as
select
    p.id,
    p.uri,
    p.name1,
    p.name1_lang,
    p.name2,
    p.name2_lang,
    p.inspire_type,
    p.local_type,
    p.easting,
    p.northing,
    st_x(st_transform(p.geom, 4326)) as longitude,
    st_y(st_transform(p.geom, 4326)) as latitude,
    p.most_detail_view_resolution,
    p.least_detail_view_resolution,
    p.bbox_xmin,
    p.bbox_ymin,
    p.bbox_xmax,
    p.bbox_ymax,
    p.postcode_district,
    p.populated_place,
    d.ladnm as district,
    c.ctynm as county,
    r.rgnnm as region,
    co.ctrynm as country,
    p.same_as_dbpedia,
    p.same_as_geonames,
    st_asgeojson(st_transform(p.geom, 4326))::json as geojson,
    st_asgeojson(st_transform(st_makeenvelope(p.bbox_xmin, p.bbox_ymin, p.bbox_xmax, p.bbox_ymax, 27700), 4326))::json as bbox_geojson
from place_name p
left join lad_boundary d on p.district_code = d.ladcd
left join county_boundary c on p.county_unitary_code = c.ctycd
left join region_boundary r on p.region_code = r.rgncd
left join country_boundary co on p.country_code = co.ctrycd;
