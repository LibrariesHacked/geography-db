create view vw_lad_boundaries as
select
    l.lad19cd,
    l.lad19nm,
    l.lad19nmw,
    l.geom
from lad_boundary l;