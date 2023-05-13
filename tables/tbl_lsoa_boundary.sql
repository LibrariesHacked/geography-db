create table lsoa_boundary (
    lsoacd character (9),
    lsoanm character varying(200)
);

select AddGeometryColumn ('public', 'lsoa_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'lsoa_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_lsoaboundary_lsoacd on lsoa_boundary (lsoacd);
cluster lsoa_boundary using idx_lsoaboundary_lsoacd;
create index idx_lsoaboundary_geom on lsoa_boundary using gist (geom);
create index idx_lsoaboundary_bbox on lsoa_boundary using gist (bbox);
