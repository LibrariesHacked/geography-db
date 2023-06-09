create view vw_postcode_smallarea_uk as
select
    p.postcode,
    p.postcode_sector_trimmed,
    case when p.country = 'N92000002' then p.oa_21 else p.lsoa_21 end as smallarea,
	p.terminated
from postcode_lookup p;