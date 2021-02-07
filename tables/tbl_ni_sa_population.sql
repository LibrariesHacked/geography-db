create table ni_sa_population (
  sa_code character (9),
  population integer,
  constraint pk_nisapopulation_sacode primary key (sa_code)
);

create unique index idx_nisapopulation_sacode on ni_sa_population (sa_code);
cluster ni_sa_population using idx_nisapopulation_sacode;