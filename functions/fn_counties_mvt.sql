create or replace function fn_counties_mvt(tile_x integer, tile_y integer, zoom integer) returns bytea as 
$$
declare
  layer_name character varying (100) := 'county_boundaries';
  tile_bbox geometry := fn_bbox(tile_x, tile_y, zoom);
  tile bytea;
begin

select g.tile into tile from generated_mvt g where g.layer = layer_name and g.x = tile_x and g.y = tile_y and g.z = zoom;
if found then 
  return tile;
end if;

select st_asmvt(s, layer_name, 4096, 'mvt_geom') into tile
from (
  select c.cty19cd, c.cty19nm, st_asmvtgeom(st_transform(c.geom, 3857), tile_bbox, 4096, 256, true) as mvt_geom
  from county_boundary c
  where c.bbox && tile_bbox
) as s;

insert into generated_mvt(layer, x, y, z, tile) values(layer_name, tile_x, tile_y, zoom, tile);

return tile;
end;
$$
language plpgsql;