create table lad_boundary (
    lad19cd character (9),
    lad19nm character varying(200),
    lad19nmw character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'lad_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'lad_boundary', 'bbox', 27700, 'POLYGON', 2);

create unique index idx_ladboundary_lad19cd on lad_boundary (lad19cd);
cluster lad_boundary using idx_ladboundary_lad19cd;
create unique index idx_ladboundary_lad19nm on lad_boundary (lad19nm);
create index idx_ladboundary_geom on lad_boundary using gist (geom);
create index idx_ladboundary_bbox on lad_boundary using gist (bbox);