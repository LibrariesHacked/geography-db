create table oa_population (
    oa character (9),
    population integer
);

create unique index cuidx_oapopulation_oa on oa_population (oa);
cluster oa_population using cuidx_oapopulation_oa;
