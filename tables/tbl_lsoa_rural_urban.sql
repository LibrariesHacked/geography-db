create table lsoa_rural_urban
(
  lsoacd character varying(9),
  rucd character varying(2),
  constraint pk_ruralurban_lsoacd primary key (lsoacd)
);

create unique index cuidx_ruralurban_lsoacd on lsoa_rural_urban (lsoacd);
cluster lsoa_rural_urban using cuidx_ruralurban_lsoacd;
