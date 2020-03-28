create view vw_region_boundaries as
select
    r.rgn18cd,
    r.rgn18nm,
    r.geom
from region_boundary r;