create table datazone_boundary (
    datazone character (9),
    name character varying(200),
    totpop2011 integer,
    respop2011 integer,
    hhcnt2011 integer,
    stdareaha numeric,
    stdareakm2 numeric,
    shape_leng numeric,
    shape_area numeric
);

select AddGeometryColumn ('public', 'datazone_boundary', 'geom', 27700, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'datazone_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_datazoneboundary_datazone on datazone_boundary (datazone);
cluster datazone_boundary using idx_datazoneboundary_datazone;
create index idx_datazoneboundary_geom on datazone_boundary using gist (geom);
create index idx_datazoneboundary_bbox on datazone_boundary using gist (bbox);