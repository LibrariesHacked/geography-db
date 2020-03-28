create table ward_boundary (
    wd19cd character (9),
    wd19nm character varying(200),
    wd19nmw character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'ward_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);

create unique index idx_wardboundary_wd19cd on ward_boundary (wd19cd);
cluster ward_boundary using idx_wardboundary_wd19cd;
create index idx_wardboundary_geom on ward_boundary using gist (geom);