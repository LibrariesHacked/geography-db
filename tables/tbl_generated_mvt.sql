create table generated_mvt (
    layer_id integer,
    x integer,
    y integer,
    z integer,
    tile bytea,
    constraint pk_generatedmvt_layer_x_y_z primary key (layer_id, x, y, z),
    constraint fk_generatedmvt_layerid foreign key (layer_id) references generated_mvt_type (id)
);

create unique index idx_generatedmvt_layerid_x_y_z on generated_mvt (layer_id, x, y, z);
cluster generated_mvt using idx_generatedmvt_layerid_x_y_z;
