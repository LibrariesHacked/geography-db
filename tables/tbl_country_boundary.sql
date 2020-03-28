create table country_boundary (
    ctry18cd character (9),
    ctry18nm character varying(200),
    ctry18nmw character varying(200),
    st_areasha numeric,
    st_lengths numeric
);

select AddGeometryColumn ('public', 'country_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);

create unique index idx_countryboundary_ctry18cd on country_boundary (ctry18cd);
cluster country_boundary using idx_countryboundary_ctry18cd;
create index idx_countryboundary_geom on country_boundary using gist (geom);