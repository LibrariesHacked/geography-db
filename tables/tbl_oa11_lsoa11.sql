create table oa11_lsoa11 (
  oa11 character (9),
  lsoa11 character (9)
);

create unique index cuidx_oa11lsoa11_oa11_lsoa11 on oa11_lsoa11 (oa11, lsoa11);
cluster oa11_lsoa11 using cuidx_oa11lsoa11_oa11_lsoa11;

create index idx_oa11lsoa11_oa11 on oa11_lsoa11 (oa11);
create index idx_oa11lsoa11_lsoa11 on oa11_lsoa11 (lsoa11);
