create table lad_boundary (
    ladcd character (9),
    ladnm character varying(200)
);

select AddGeometryColumn ('public', 'lad_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'lad_boundary', 'geom_generalised', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'lad_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_ladboundary_ladcd on lad_boundary (ladcd);
cluster lad_boundary using idx_ladboundary_ladcd;
create unique index idx_ladboundary_ladnm on lad_boundary (ladnm);
create index idx_ladboundary_geom on lad_boundary using gist (geom);
create index idx_ladboundary_geomgeneralised on lad_boundary using gist (geom_generalised);
create index idx_ladboundary_bbox on lad_boundary using gist (bbox);