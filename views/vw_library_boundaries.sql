create view vw_library_boundaries as
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
    uk.bbox
from 
    (select
        ladcd as utlacd,
        ladnm as utlanm,
        geom,
        bbox
    from lad_boundary
    where ladcd in (select utlacd from upper_codes)
    union all
    select
        ctycd as utlacd,
        ctynm as utlanm,
        geom,
        bbox
    from county_boundary
    where ctycd in (select utlacd from upper_codes)
    union all
    select
        ladcd as utlacd,
        ladnm as utlanm,
        geom,
        bbox
    from lad_boundary
    where ladcd LIKE 'S%'
    union all
    select
        ctrycd as utlacd,
        ctrynm as utlanm,
        geom,
        bbox
    from country_boundary
    where ctrynm = 'Northern Ireland') as uk
join administrative_names ad on ad.code = uk.utlacd;