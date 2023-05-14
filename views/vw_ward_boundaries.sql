create view vw_ward_boundaries as
select
    w.wdcd,
    w.wdnm,
    w.geom
from ward_boundary w;