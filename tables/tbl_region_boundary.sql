create table region_boundary (
    rgn18cd character (9),
    rgn18nm character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'region_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'region_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_regionboundary_rgn18cd on region_boundary (rgn18cd);
cluster region_boundary using idx_regionboundary_rgn18cd;
create index idx_regionboundary_geom on region_boundary using gist (geom);
create index idx_regionboundary_bbox on region_boundary using gist (bbox);