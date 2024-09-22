create table lsoa11_lsoa21 (
  lsoa11 character (9),
  lsoa21 character (9)
);

create unique index cuidx_lsoa11lsoa21_lsoa11_lsoa21 on lsoa11_lsoa21 (lsoa11, lsoa21);
cluster lsoa11_lsoa21 using cuidx_lsoa11lsoa21_lsoa11_lsoa21;

create index idx_lsoa11lsoa21_lsoa11 on lsoa11_lsoa21 (lsoa11);
create index idx_lsoa11lsoa21_lsoa21 on lsoa11_lsoa21 (lsoa21);
