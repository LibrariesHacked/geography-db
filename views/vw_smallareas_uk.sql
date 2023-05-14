create view vw_smallareas_uk as
select
  l.lsoacd as code,
  l.lsoanm as area_name,
  p.population as population,
  i.imd_decile as imd_decile,
  st_transform(l.geom, 3857) as geom,
  l.bbox as bbox
from lsoa_boundary l
join (
  select 
    lsoa_code as lsoa_code,
    imd_decile as imd_decile
  from lsoa_imd
  union all
  select
    lsoacd as lsoa_code,
    decile as imd_decile
  from lsoa_wimd
) as i on i.lsoa_code =  l.lsoacd
join lsoa_population p on p.lsoacd = l.lsoacd
union all
select 
	d.datazone as code,
	d.name as area_name,
  dip.population,
	dip.simd_decile as imd_decile,
	st_transform(d.geom, 3857) as geom,
  d.bbox as bbox
from datazone_boundary d
join datazone_imd_population dip on dip.datazone = d.datazone
union all
select 
  nb.sa_code as code,
  nb.soa_code as area_name,
  np.population as population,
  ni.imd_decile as imd_decile,
  st_transform(nb.geom, 3857) as geom,
  nb.bbox as bbox
from ni_sa_boundary nb
join ni_sa_imd ni on ni.sa_code = nb.sa_code
join ni_sa_population as np on np.sa_code = nb.sa_code;