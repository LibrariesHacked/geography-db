create view vw_lsoa_boundaries as
select
    l.lsoa11cd,
    l.lsoa11nm,
    l.geom
from lsoa_boundary l;