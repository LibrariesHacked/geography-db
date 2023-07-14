create view vw_built_up_area_boundaries as
select
    b.buacd,
    b.buanm,
    b.geom
from built_up_area_boundary b;
