create view vw_lad_boundaries as
select
    l.ladcd,
    l.ladnm,
    l.geom,
    l.geom_generalised,
from lad_boundary l;