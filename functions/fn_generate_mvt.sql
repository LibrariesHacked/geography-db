create or replace function fn_generate_mvt(mvt_function character varying(100), min_zoom integer, max_zoom integer) returns void as 
$$
declare
  current_zoom integer := min_zoom;
  current_x integer := 0;
  current_y integer := 0;
begin

loop
  exit when current_zoom > max_zoom; 

  current_x := 0;
  loop
    exit when current_x > (power(2, current_zoom) - 1);

    current_y := 0;
    loop
      exit when current_y > (power(2, current_zoom) - 1);
      execute 'select ' || mvt_function || '(' || current_x || ', ' || current_y || ',' || current_zoom || ')';
      current_y := current_y + 1; 
    end loop;

    current_x := current_x + 1; 
  end loop;
  current_zoom := current_zoom + 1;
end loop;

end;
$$
language plpgsql;