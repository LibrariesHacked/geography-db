create or replace function fn_lsoas_mvt(tile_x integer, tile_y integer, zoom integer) returns bytea as 
$$
declare
  layer_name character varying (100) := 'lsoa_boundaries';
  tile_bbox geometry := fn_bbox(tile_x, tile_y, zoom);
	tile bytea;
begin

select g.tile into tile from generated_mvt g where g.layer = layer_name and g.x = tile_x and g.y = tile_y and g.z = zoom;
if found then 
  return tile;
end if;

select st_asmvt(s, layer_name, 4096, 'mvt_geom') into tile
from (
  select b.lsoa11cd, p.population, st_asmvtgeom(st_transform(b.geom, 3857), tile_bbox, 4096, 256, true) as mvt_geom
  from lsoa_boundary b
  join lsoa_population p on p.lsoa11cd = b.lsoa11cd
  where b.bbox && tile_bbox
) as s;

insert into generated_mvt(layer, x, y, z, tile) values(layer_name, tile_x, tile_y, zoom, tile);

return tile;
end;
$$
language plpgsql;