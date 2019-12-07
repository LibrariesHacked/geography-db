create or replace function fn_postcodelsoasfromsectors(postcode_sectors jsonb) returns
    table (
        lsoa character (9),
        postcode character varying []
    ) as
$$
begin
    return query (
        with sectors as
            (select replace(value, ' ', '') as postcode_sector from jsonb_array_elements_text(postcode_sectors))
        select
            p.lsoa, 
            array_agg(p.postcode) as postcodes
        from sectors s
        join postcode_lookup p on p.postcode_sector_trimmed = s.postcode_sector
        group by p.lsoa
    );
end;
$$
language plpgsql;