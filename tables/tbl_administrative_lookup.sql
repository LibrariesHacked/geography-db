create table administrative_lookup (
    wd19cd character (9),
    lad19cd character (9),
    cty19cd character (9),
    rgn19cd character (9),
    ctry19cd character (9),
    constraint pk_administrativelookup_wd19cd_lad19cd primary key (wd19cd, lad19cd),
    constraint fk_administrativelookup_wd19cd foreign key (wd19cd) references ward_boundary (wd19cd),
    constraint fk_administrativelookup_lad19cd foreign key (lad19cd) references lad_boundary (lad19cd),
    constraint fk_administrativelookup_rgn19cd foreign key (rgn19cd) references region_boundary (rgn18cd),
    constraint fk_administrativelookup_ctry19cd foreign key (ctry19cd) references country_boundary (ctry18cd)
);

create unique index idx_administrativelookup_wd19cd on administrative_lookup (wd19cd);
cluster administrative_lookup using idx_administrativelookup_wd19cd;
create index idx_administrativelookup_lad19cd on administrative_lookup (lad19cd);
create index idx_administrativelookup_cty19cd on administrative_lookup (cty19cd);
create index idx_administrativelookup_rgn19cd on administrative_lookup (rgn19cd);
create index idx_administrativelookup_ctry19cd on administrative_lookup (ctry19cd);