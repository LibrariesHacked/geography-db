create table lsoa_population (
  lsoacd character (9),
  population integer,
  constraint pk_lsoapopulation_lsoacd primary key (lsoacd)
);

create unique index idx_lsoapopulation_lsoacd on lsoa_population (lsoacd);
cluster lsoa_population using idx_lsoapopulation_lsoacd;