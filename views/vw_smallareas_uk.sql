create or replace view vw_smallareas_uk as
select
  l.lsoacd as code,
  l.lsoanm as area_name,
  ut.utlacd as authority_code,
  ru.rucd as rural_urban_code,
  p.population as population,
  i.imd_decile as imd_decile,
  st_transform(l.geom, 3857) as geom,
  st_transform(l.geom, 3857) as geom_generalised,
  l.bbox as bbox
from lsoa_boundary l
join lsoa_upper_lookup ut on ut.lsoacd = l.lsoacd
left join lsoa11_lsoa21 l11_l21 on l11_l21.lsoa21 = l.lsoacd
left join (
  select 
    lsoa_code as lsoa_code,
    imd_decile as imd_decile
  from lsoa_imd
  union all
  select
    lsoacd as lsoa_code,
    decile as imd_decile
  from lsoa_wimd
) as i on i.lsoa_code = l11_l21.lsoa11
left join lsoa_rural_urban ru on ru.lsoacd = l11_l21.lsoa11
join lsoa_population p on p.lsoacd = l.lsoacd
union all
select 
	d.datazone as code,
	d.name as area_name,
  null as authority_code,
  null as rural_urban_code,
  dip.population,
	dip.simd_decile as imd_decile,
	st_transform(d.geom, 3857) as geom,
  st_transform(d.geom, 3857) as geom_generalised,
  d.bbox as bbox
from datazone_boundary d
join datazone_imd_population dip on dip.datazone = d.datazone
union all
select 
  nb.sa_code as code,
  nb.soa_code as area_name,
  null as authority_code,
  null as rural_urban_code,
  np.population as population,
  ni.imd_decile as imd_decile,
  st_transform(nb.geom, 3857) as geom,
  st_transform(nb.geom, 3857) as geom_generalised,
  nb.bbox as bbox
from ni_sa_boundary nb
join ni_sa_imd ni on ni.sa_code = nb.sa_code
join ni_sa_population as np on np.sa_code = nb.sa_code;