create view vw_upper_library_boundaries as
select distinct 
    ul.utla19cd,
    case when cb.geom is not null then cb.geom
    else lb.geom 
    end as geom
from lower_upper_lookup ul
left join lad_boundary lb on lb.lad19cd = ul.utla19cd
left join county_boundary cb on cb.cty19cd = ul.utla19cd;