create table county_boundary (
    cty19cd character (9),
    cty19nm character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'county_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'county_boundary', 'bbox', 27700, 'POLYGON', 2);

create unique index idx_countyboundary_cty19cd on county_boundary (cty19cd);
cluster county_boundary using idx_countyboundary_cty19cd;
create index idx_countyboundary_geom on county_boundary using gist (geom);
create index idx_countyboundary_bbox on county_boundary using gist (bbox);