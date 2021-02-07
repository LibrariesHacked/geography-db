create table ni_sa_boundary (
    sa_code character (9),
    soa_code character (8),
    constraint pk_nisaboundary_sacode primary key (sa_code)
);

select AddGeometryColumn ('public', 'ni_sa_boundary', 'geom', 29902, 'MULTIPOLYGON', 2);
select AddGeometryColumn ('public', 'ni_sa_boundary', 'bbox', 3857, 'POLYGON', 2);

create unique index idx_nisaboundary_sacode on ni_sa_boundary (sa_code);
cluster ni_sa_boundary using idx_nisaboundary_sacode;
create index idx_nisaboundary_geom on ni_sa_boundary using gist (geom);
create index idx_nisaboundary_bbox on ni_sa_boundary using gist (bbox);