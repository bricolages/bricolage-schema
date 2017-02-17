create table strload_streams
( stream_id serial not null primary key
, stream_name text not null
, table_id integer
, disabled boolean not null
, discard boolean default false not null
, no_dispatch boolean default false not null
);

insert into strload_streams
select
    id as stream_id
    , p.table_id as stream_name
    , s.table_id as table_id
    , p.disabled
    , p.discard
    , p.no_dispatch
from preproc_tables as p
    left outer join strload_tables as s on s.data_source_id = p.table_id
;

create table strload_filters
( filter_id serial not null primary key
, stream_id integer not null
, target_column text not null
, application_order integer default 0 not null
, operator_id text not null
, params text not null
, created_at timestamp without time zone not null
, updated_at timestamp without time zone not null
);

insert into strload_filters
select
    p.id as filter_id
    , s.stream_id as stream_id
    , p.target_column as target_column
    , p.application_order as application_order
    , p.operator_id as operator_id
    , p.params as params
    , p.created_at as created_at
    , p.updated_at as updated_at
from preproc_definition as p
    left outer join strload_streams as s on s.stream_name = p.target_table
;
