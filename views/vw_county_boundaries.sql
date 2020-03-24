create view vw_county_boundaries as
select
    l.cty19cd,
    l.cty19nm,
    l.geom
from county_boundary l;