create table administrative_names (
    code character (9),
    name character varying (100),
    nice_name character varying (100),
    region character varying (100),
    nation character varying (100),
    constraint pk_administrativenames_code primary key (code)
);

create unique index idx_administrativenames_code on administrative_names (code);
cluster administrative_names using idx_administrativenames_code;