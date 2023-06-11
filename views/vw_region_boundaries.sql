create view vw_region_boundaries as
select
    r.rgncd,
    r.rgnnm,
    r.geom
from region_boundary r;