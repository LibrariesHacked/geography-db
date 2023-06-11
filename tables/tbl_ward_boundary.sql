create table ward_boundary (
    wdcd character (9),
    wdnm character varying(200)
);

select AddGeometryColumn ('public', 'ward_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'ward_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_wardboundary_wdcd on ward_boundary (wdcd);
cluster ward_boundary using idx_wardboundary_wdcd;
create index idx_wardboundary_geom on ward_boundary using gist (geom);
create index idx_wardboundary_bbox on ward_boundary using gist (bbox);
