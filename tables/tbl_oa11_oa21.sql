create table oa11_oa21 (
  oa11 character (9),
  oa21 character (9)
);

create unique index cuidx_oa11oa21_oa11_oa21 on oa11_oa21 (oa11, oa21);
cluster oa11_oa21 using cuidx_oa11oa21_oa11_oa21;

create index idx_oa11oa21_oa11 on oa11_oa21 (oa11);
create index idx_oa11oa21_oa21 on oa11_oa21 (oa21);
