create table lower_upper_lookup (
    ltla19cd character (9),
    utla19cd character (9),
    constraint pk_lowerupperlookup_ltla19cd_utla19cd primary key (ltla19cd, utla19cd)
);

create unique index idx_lowerupperlookup_ltla19cd_utla19cd on lower_upper_lookup (ltla19cd, utla19cd);
cluster lower_upper_lookup using idx_lowerupperlookup_ltla19cd_utla19cd;