create table built_up_area_boundary (
    buacd character (9),
    buanm character varying(200)
);

select AddGeometryColumn ('public', 'built_up_area_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'built_up_area_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_builtupareaboundary_buacd on built_up_area_boundary (buacd);
cluster built_up_area_boundary using idx_builtupareaboundary_buacd;
create index idx_builtupareaboundary_geom on built_up_area_boundary using gist (geom);
create index idx_builtupareaboundary_bbox on built_up_area_boundary using gist (bbox);
