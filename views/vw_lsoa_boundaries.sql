create view vw_lsoa_boundaries as
select
    l.lsoa11cd,
    l.lsoa11nm,
    l.lsoa11nmw,
    l.st_areasha,
    l.st_lengths,
    l.geom
from lsoa_boundary l;