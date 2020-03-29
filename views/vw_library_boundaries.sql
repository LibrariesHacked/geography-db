create view vw_library_boundaries as
with boundaries as (
    select lad19cd as code, lad19nm as name, lad19nmw as welsh_name, geom 
    from lad_boundary
    union all
    select cty19cd as code, cty19nm as name, cty19nm as welsh_name, geom 
    from county_boundary
)
select distinct 
    ul.utla19cd as utla19cd,
    b.name as utla19nm,
    b.welsh_name as utla19nmw,
    b.geom as geom
from lower_upper_lookup ul
left join boundaries b on b.code = ul.utla19cd
union all
select lad19cd as utla19cdd, lad19nm as utla19nm, lad19nmw as utlanmw, geom
from lad_boundary
where lad19cd LIKE 'S%';