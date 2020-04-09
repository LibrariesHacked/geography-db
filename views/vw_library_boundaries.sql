create view vw_library_boundaries as
with upper_codes as (
    select utla19cd
    from lower_upper_lookup
)
select
    lad19cd as utla19cd,
    lad19nm as utla19nm,
    lad19nmw as utla19nmw,
    st_simplify(st_snaptogrid(geom, 1), 50, false) as geom,
    bbox
from lad_boundary
where lad19cd in (select utla19cd from upper_codes)
union all
select
    cty19cd as utla19cd,
    cty19nm as utla19nm,
    cty19nm as utla19nmw,
    st_simplify(st_snaptogrid(geom, 1), 50, false) as geom,
    bbox
from county_boundary
where cty19cd in (select utla19cd from upper_codes)
union all
select
    lad19cd as utla19cd,
    lad19nm as utla19nm,
    lad19nmw as utla19nmw,
    st_simplify(st_snaptogrid(geom, 1), 50, false) as geom,
    bbox
from lad_boundary
where lad19cd LIKE 'S%'
union all
select
    ctry18cd as utla19cd,
    ctry18nm as utla19nm,
    ctry18nmw as utla19nmw,
    st_simplify(st_snaptogrid(geom, 1), 50, false) as geom,
    bbox
from country_boundary
where ctry18nm = 'Northern Ireland';