create or replace function fn_counties_mvt(x integer, y integer, z integer) returns bytea as 
$$
declare 
    bbox geometry := fn_bbox(x, y, z);
	tile bytea;
begin
select st_asmvt(s, 'county_boundary', 4096, 'mvt_geom') into tile
from (
    select cty19cd, cty19nm, st_asmvtgeom(st_transform(geom, 3857), bbox, 4096, 256, true) as mvt_geom
    from county_boundary
    where st_intersects(st_transform(geom, 3857), bbox)
) as s;
return tile;
end;
$$
language plpgsql;