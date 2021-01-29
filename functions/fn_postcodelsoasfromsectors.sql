create or replace function fn_postcodelsoasfromsectors(postcode_sectors json) returns
  table (
    lsoa character varying (9),
    postcode character varying []
  ) as
$$
begin
  return query (
    with sectors as
      (select value as postcode_sector from json_array_elements_text(postcode_sectors)
    )
    select
      coalesce(p.lsoa, 'Unknown') as lsoa,
      array_agg(p.postcode) as postcodes
    from sectors s
    join postcode_lookup p on p.postcode_sector_trimmed = s.postcode_sector
    where p.terminated is false
    group by coalesce(p.lsoa, 'Unknown')
    union all
    select
      'Terminated' as lsoa,
      array_agg(p.postcode) as postcodes
    from sectors s
    join postcode_lookup p on p.postcode_sector_trimmed = s.postcode_sector
    where p.terminated is true
  );
end;
$$
language plpgsql;