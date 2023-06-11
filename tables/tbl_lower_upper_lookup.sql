create table lower_upper_lookup (
    ltlacd character (9),
    utlacd character (9),
    constraint pk_lowerupperlookup_ltlacd_utlacd primary key (ltlacd, utlacd)
);

create unique index idx_lowerupperlookup_ltlacd_utlacd on lower_upper_lookup (ltlacd, utlacd);
cluster lower_upper_lookup using idx_lowerupperlookup_ltlacd_utlacd;
create index idx_lowerupperlookup_utlacd on lower_upper_lookup (utlacd);
