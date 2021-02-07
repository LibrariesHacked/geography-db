create table lsoa_imd
(
  lsoa_code character varying(9) not null, lsoa_name text, district_code character varying(9), district_name text,
  imd_score numeric, imd_rank integer, imd_decile integer,
  income_score numeric, income_rank integer, income_decile integer,
  employment_score numeric, employment_rank integer, employment_decile integer,
  education_score numeric, education_rank integer, education_decile integer,
  health_score numeric, health_rank integer, health_decile integer,
  crime_score numeric, crime_rank integer, crime_decile integer,
  housing_score numeric, housing_rank integer, housing_decile integer,
  environment_score numeric, environment_rank integer, environment_decile integer,
  idaci_score numeric, idaci_rank integer, idaci_decile integer,
  idaopi_score numeric, idaopi_rank integer, idaopi_decile integer,
  children_score numeric, children_rank integer, children_decile integer,
  adultskills_score numeric, adultskills_rank integer, adultskills_decile integer,
  geographical_score numeric, geographical_rank integer, geographical_decile integer,
  wider_score numeric, wider_rank integer, wider_decile integer,
  indoors_score numeric, indoors_rank integer, indoors_decile integer,
  outdoors_score numeric, outdoors_rank integer, outdoors_decile integer,
  population_total integer, dependent_children integer, sixteen_fiftynine integer, over_sixty integer, working_age numeric,
  constraint pk_imd_code primary key (lsoa_code)
);

create unique index idx_lsoaimd_lsoacode on lsoa_imd (lsoa_code);
cluster lsoa_imd using idx_lsoaimd_lsoacode;