create view vw_postcodes as
select
    p.postcode,
    p.postcode_trimmed,
    p.postcode_sector,
    p.postcode_district,
    p.postcode_area,
    p.terminated,
    p.lsoa_11 as lsoa,
	lb.lsoanm as lsoa_name,
    p.ward,
	wb.wdnm as ward_name,
    p.district,
	db.ladnm as district_name,
    p.county,
	cb.ctynm as county_name,
    p.library_service,
	vlb.name as library_service_name,
    p.region,
	rb.rgnnm as region_name,
    p.country,
	ctry.ctrynm as country_name,
    p.longitude,
    p.latitude,
    p.easting,
    p.northing,
    p.geom
from postcode_lookup p 
left join lsoa_boundary lb on lb.lsoacd = p.lsoa_21
left join ward_boundary wb on wb.wdcd = p.ward
left join lad_boundary db on db.ladcd = p.district
left join county_boundary cb on cb.ctycd = p.county
left join vw_library_boundaries vlb on vlb.code = p.library_service
left join region_boundary rb on rb.rgncd = p.region
join country_boundary ctry on ctry.ctrycd = p.country;
