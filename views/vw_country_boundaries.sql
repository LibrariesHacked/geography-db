create view vw_country_boundaries as
select
    c.ctry18cd,
    c.ctry18nm,
    c.ctry18nmw,
    c.geom
from country_boundary c;