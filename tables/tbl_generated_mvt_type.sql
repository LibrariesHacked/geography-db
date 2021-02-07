create table generated_mvt_type (
    id serial,
    type character varying (50),
    constraint pk_generatedmvttype_id primary key (id)
);

create unique index idx_generatedmvttype_id on generated_mvt_type (id);
cluster generated_mvt_type using idx_generatedmvttype_id;