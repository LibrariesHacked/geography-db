create view vw_county_boundaries as
select
    l.ctycd,
    l.ctynm,
    l.geom
from county_boundary l;