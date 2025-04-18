create or replace view vw_library_boundaries as
with upper_codes as (
    select distinct utlacd
    from lower_upper_lookup
)
select 
    ad.code,
    ad.name,
    ad.nice_name,
    ad.region,
    ad.nation,
    uk.geom,
    uk.geom_generalised,
    uk.bbox
from 
    (select
        ladcd as utlacd,
        ladnm as utlanm,
        geom,
        geom_generalised,
        bbox
    from lad_boundary
    where ladcd in (select utlacd from upper_codes)
    union all
    select
        ctycd as utlacd,
        ctynm as utlanm,
        geom,
        geom_generalised,
        bbox
    from county_boundary
    where ctycd in (select utlacd from upper_codes)
    union all
    select
        ladcd as utlacd,
        ladnm as utlanm,
        geom,
        geom_generalised,
        bbox
    from lad_boundary
    where ladcd LIKE 'S%') as uk
join administrative_names ad on ad.code = uk.utlacd
union all
select
    ctrycd as code,
    cast(ctrynm as character varying(100)) as name,
    cast('LibrariesNI' as character varying(100)) as nice_name,
    cast('Northern Ireland' as character varying(100)) as region,
    cast('Northern Ireland' as character varying(100)) as nation,
    geom,
    geom as geom_generalised,
    bbox
from country_boundary
where ctrynm = 'Northern Ireland';