create or replace function fn_library_authorities_mvt(x integer, y integer, z integer) returns bytea as 
$$
declare 
    tile_bbox geometry := fn_bbox(x, y, z);
	tile bytea;
begin
select st_asmvt(s, 'library_authority_boundaries', 4096, 'mvt_geom') into tile
from (
    select b.utla19cd, b.utla19nm, b.utla19nmw, st_asmvtgeom(st_transform(b.geom, 3857), tile_bbox, 4096, 256, true) as mvt_geom
    from vw_library_boundaries b
    where st_intersects(st_transform(b.bbox, 3857), tile_bbox)
) as s;
return tile;
end;
$$
language plpgsql;W