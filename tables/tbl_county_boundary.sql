create table county_boundary (
    ctycd character (9),
    ctynm character varying(200)
);

select AddGeometryColumn ('public', 'county_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'county_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_countyboundary_ctycd on county_boundary (cty19cd);
cluster county_boundary using idx_countyboundary_ctycd;
create index idx_countyboundary_geom on county_boundary using gist (geom);
create index idx_countyboundary_bbox on county_boundary using gist (bbox);
