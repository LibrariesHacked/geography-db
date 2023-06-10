create view vw_lsoa_boundaries as
select
    l.lsoacd,
    l.lsoanm,
    l.geom,
    l.geom_generalised
from lsoa_boundary l;