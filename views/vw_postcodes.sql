create view vw_postcodes as
select
    p.postcode,
    p.postcode_trimmed,
    p.postcode_sector,
    p.postcode_district,
    p.postcode_area,
    p.terminated,
    p.oa,
    p.lsoa,
    p.msoa,
    p.district,
    p.county,
    p.region,
    p.country,
    p.longitude,
    p.latitude,
    p.easting,
    p.northing
from postcode_lookup p;