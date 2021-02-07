create table datazone_imd_population
(
  datazone character varying(9),
  simd_rank numeric,
  simd_decile integer,
  income_rank numeric,
  employment_rank numeric,
  education_rank numeric,
  health_rank numeric,
  access_rank numeric,
  crime_rank numeric,
  housing_rank numeric,
  population integer,
  constraint pk_datazoneimdpopulation_datazone primary key (datazone)
);
    
create unique index idx_datazoneimdpopulation_datazone on datazone_imd_population (datazone);
cluster datazone_imd_population using idx_datazoneimdpopulation_datazone;