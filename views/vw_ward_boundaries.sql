create view vw_ward_boundaries as
select
    w.wd19cd,
    w.wd19nm,
    w.wd19nmw,
    w.geom
from ward_boundary w;