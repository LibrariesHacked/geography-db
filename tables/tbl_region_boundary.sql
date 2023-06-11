create table region_boundary (
    rgncd character (9),
    rgnnm character varying(200)
);

select AddGeometryColumn ('public', 'region_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'region_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_regionboundary_rgncd on region_boundary (rgncd);
cluster region_boundary using idx_regionboundary_rgncd;
create index idx_regionboundary_geom on region_boundary using gist (geom);
create index idx_regionboundary_bbox on region_boundary using gist (bbox);
