create or replace view vw_built_up_area_boundaries as
select 
    bua.buacd as code,
    bua.buanm as name,
    bua.geom as geom,
    min(oa21_imd.imd_decile) as min_imd_decile,
    sum(pop.population) as population,
    case
        when sum(pop.population) is null then 'Villages and small communities'
        when sum(pop.population) < 7500 then 'Villages and small communities'
        when sum(pop.population) >= 7500 and sum(pop.population) < 25000 then 'Small Towns'
        when sum(pop.population) >= 25000 and sum(pop.population) < 60000 then 'Medium Towns'
        when sum(pop.population) >= 60000 and sum(pop.population) < 175000 then 'Large Towns'
        when sum(pop.population) >= 175000 then 'Cities'
        else null 
    end as classification
from built_up_area_boundary bua
left join oa_bua oa
on oa.bua = bua.buacd
left join oa_population pop
on pop.oa = oa.oa
left join (
    select
        oa21, min(imd_decile) as imd_decile
    from oa11_oa21 oas21
    left join oa11_lsoa11 lsoas11
    on lsoas11.oa11 = oas21.oa11
    left join lsoa_imd i
    on i.lsoa_code = lsoas11.lsoa11
    group by oa21
    order by oa21
) oa21_imd
on oa21_imd.oa21 = oa.oa
group by bua.buacd, bua.buanm, bua.geom;
