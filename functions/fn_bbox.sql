create or replace function fn_bbox(x integer, y integer, zoom integer) returns geometry as
$$
declare
    max numeric := 20037508.34;
    res numeric := (max * 2)/(2 ^ zoom);
    bbox geometry;
begin
    return ST_MakeEnvelope(
        -max + (x * res),
        max - (y * res),
        -max + (x * res) + res,
        max - (y * res) - res,
    3857);
end;
$$
language plpgsql;