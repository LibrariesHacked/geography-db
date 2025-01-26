create table lsoa11_lsoa21_exact (
  lsoa11 character (9),
  lsoa21 character (9),
  changeindicator character (1) -- U, S, M, X
);

create unique index cuidx_lsoa11lsoa21exact_lsoa11_lsoa21 on lsoa11_lsoa21_exact (lsoa11, lsoa21);
cluster lsoa11_lsoa21_exact using cuidx_lsoa11lsoa21exact_lsoa11_lsoa21;

create index idx_lsoa11lsoa21exact_lsoa11 on lsoa11_lsoa21_exact (lsoa11);
create index idx_lsoa11lsoa21exact_lsoa21 on lsoa11_lsoa21_exact (lsoa21);
