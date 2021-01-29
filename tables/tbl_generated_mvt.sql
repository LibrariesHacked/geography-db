create table generated_mvt (
    layer character varying (100),
    x integer,
    y integer,
    z integer,
    tile bytea,
    constraint pk_generatedmvt_layer_x_y_z primary key (layer, x, y, z)
);

create unique index idx_generatedmvt_layer_x_y_z on generated_mvt (layer, x, y, z);
cluster generated_mvt using idx_generatedmvt_layer_x_y_z;