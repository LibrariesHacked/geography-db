create or replace function fn_wards_mvt(x integer, y integer, z integer) returns bytea as
$$
declare
    bbox geometry := fn_bbox(x, y, z);
	tile bytea;
begin
select st_asmvt(s, 'ward_boundary', 4096, 'mvt_geom') into tile
from (
    select wd19cd, wd19nm, wd19nmw, st_asmvtgeom(st_transform(geom, 3857), bbox, 4096, 256, true) as mvt_geom
    from ward_boundary
    where st_intersects(st_transform(geom, 3857), bbox)
) as s;
return tile;
end;
$$
language plpgsql;