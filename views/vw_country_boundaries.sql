create view vw_country_boundaries as
select
    c.ctrycd,
    c.ctrynm,
    c.ctrynmw,
    c.geom
from country_boundary c;