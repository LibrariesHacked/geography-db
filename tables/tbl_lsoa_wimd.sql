create table lsoa_wimd
(
  lsoacd character varying(9),
  rank integer,
  decile integer,
  constraint pk_lsoawimd_lsoacd primary key (lsoacd)
);

create unique index idx_lsoawimd_lsoacd on lsoa_wimd (lsoacd);
cluster lsoa_wimd using idx_lsoawimd_lsoacd;
