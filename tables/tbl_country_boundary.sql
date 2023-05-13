create table country_boundary (
    ctrycd character (9),
    ctrynm character varying(200),
    ctrynmw character varying(200)
);

select AddGeometryColumn ('public', 'country_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'country_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_countryboundary_ctrycd on country_boundary (ctrycd);
cluster country_boundary using idx_countryboundary_ctrycd;
create index idx_countryboundary_geom on country_boundary using gist (geom);
create index idx_countryboundary_bbox on country_boundary using gist (bbox);
