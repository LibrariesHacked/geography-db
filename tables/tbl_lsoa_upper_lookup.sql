create table lsoa_upper_lookup
(
  lsoacd character varying(9),
  utlacd character varying(9),
  constraint pk_lsoupperlookup_lsoacd primary key (lsoacd)
);

create unique index idx_lsoaupperlookup_utlacd_lsoacd on lsoa_upper_lookup (utlacd, lsoacd);
cluster lsoa_upper_lookup using idx_lsoaupperlookup_utlacd_lsoacd;
