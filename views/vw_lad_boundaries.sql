create view vw_lad_boundaries as
select
    l.ladcd,
    l.ladnm,
    l.geom
from lad_boundary l;