create or replace function fn_postcodesfromsectors(postcode_sectors jsonb) returns
    table (
        postcode character varying (10),
        lsoa character varying (9)
    ) as
$$
begin

    return query (
        with sectors as
            (select value as postcode_sector from jsonb_array_elements_text(postcode_sectors))
        select * 
        from sectors s
        join postcode_lookup p on p.postcode_sector = s.postcode_sector
    );

end;
$$
language plpgsql;