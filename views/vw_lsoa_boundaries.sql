create view vw_lsoa_boundaries as
select
    l.lsoacd,
    l.lsoanm,
    l.geom
from lsoa_boundary l;