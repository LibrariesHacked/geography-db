create table lsoa_wimd
(
  lsoa11cd character varying(9),
  rank integer,
  decile integer,
  constraint pk_lsoawimd_lsoa11cd primary key (lsoa11cd)
);

create unique index idx_lsoawimd_lsoa11cd on lsoa_wimd (lsoa11cd);
cluster lsoa_wimd using idx_lsoawimd_lsoa11cd;