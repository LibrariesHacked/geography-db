create or replace function fn_library_authorities_mvt(tile_x integer, tile_y integer, zoom integer) returns bytea as 
$$
declare
  layer_name character varying (100) := 'library_authority_boundaries';
  layer_type integer := (select id from generated_mvt_type where type = layer_name);
  tile_bbox geometry := fn_bbox(tile_x, tile_y, zoom);
  tile bytea;
begin

select g.tile into tile from generated_mvt g where g.layer_id = layer_type and g.x = tile_x and g.y = tile_y and g.z = zoom;
if found then 
  return tile;
end if;

select st_asmvt(s, layer_name, 4096, 'mvt_geom') into tile
from (
  select b.code, st_asmvtgeom(st_transform(b.geom, 3857), tile_bbox, 4096, 256, true) as mvt_geom
  from vw_library_boundaries b
  where b.bbox && tile_bbox
) as s;

insert into generated_mvt(layer_id, x, y, z, tile) values(layer_type, tile_x, tile_y, zoom, tile);

return tile;
end;
$$
language plpgsql;