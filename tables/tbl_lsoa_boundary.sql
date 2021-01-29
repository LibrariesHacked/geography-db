create table lsoa_boundary (
    lsoa11cd character (9),
    lsoa11nm character varying(200),
    lsoa11nmw character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'lsoa_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'lsoa_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_lsoaboundary_lsoa11cd on lsoa_boundary (lsoa11cd);
cluster lsoa_boundary using idx_lsoaboundary_lsoa11cd;
create index idx_lsoaboundary_geom on lsoa_boundary using gist (geom);
create index idx_lsoaboundary_bbox on lsoa_boundary using gist (bbox);