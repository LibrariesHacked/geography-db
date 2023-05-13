create table ni_sa_imd
(
  sa_code character varying(9),
  imd_decile integer,
  imd_rank integer,
  income_rank integer,
  employment_rank integer,
  health_rank integer,
  education_rank integer,
  services_rank integer,
  environment_rank integer,
  crime_rank integer,
  constraint pk_nisaimd_sacode primary key (sa_code)
);

create unique index idx_nisaimd_sacode on ni_sa_imd (sa_code);
cluster ni_sa_imd using idx_nisaimd_sacode;
