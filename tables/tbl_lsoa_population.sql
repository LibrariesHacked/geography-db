create table lsoa_population (
  lsoa11cd character (9),
  population integer,
  constraint pk_lsoapopulation_lsoa11cd primary key (lsoa11cd)
);

create unique index idx_lsoapopulation_lsoa11cd on lsoa_population (lsoa11cd);
cluster lsoa_population using idx_lsoapopulation_lsoa11cd;