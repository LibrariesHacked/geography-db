create view vw_county_boundaries as
select
    l.ctycd,
    l.ctynm,
    l.geom,
    l.geom_generalised
from county_boundary l;