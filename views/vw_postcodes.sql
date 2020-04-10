create view vw_postcodes as
select
    p.postcode,
    p.postcode_trimmed,
    p.postcode_sector,
    p.postcode_district,
    p.postcode_area,
    p.terminated,
    p.lsoa,
	lb.lsoa11nm as lsoa_name,
    p.ward,
	wb.wd19nm as ward_name,
    p.district,
	db.lad19nm as district_name,
    p.county,
	cb.cty19nm as county_name,
    p.library_service,
	vlb.utla19nm as library_service_name,
    p.region,
	rb.rgn18nm as region_name,
    p.country,
	ctry.ctry18nm as country_name,
    p.longitude,
    p.latitude,
    p.easting,
    p.northing
from postcode_lookup p 
left join lsoa_boundary lb on lb.lsoa11cd = p.lsoa
left join ward_boundary wb on wb.wd19cd = p.ward
left join lad_boundary db on db.lad19cd = p.district
left join county_boundary cb on cb.cty19cd = p.county
left join vw_library_boundaries vlb on vlb.utla19cd = p.library_service
left join region_boundary rb on rb.rgn18cd = p.region
join country_boundary ctry on ctry.ctry18cd = p.country;