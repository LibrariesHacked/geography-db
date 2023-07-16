create table oa_bua (
  oa character (9),
  bua character (9)
);

create unique index cuidx_oabua_oa_bua on oa_bua (oa, bua);
cluster oa_bua using cuidx_oabua_oa_bua;

create index idx_oabua_oa on oa_bua (oa);
create index idx_oabua_bua on oa_bua (bua);
