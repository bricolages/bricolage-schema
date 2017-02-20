create table strload_streams_new
( stream_id serial not null primary key
, stream_name text not null
, table_id integer
, disabled boolean not null
, discard boolean default false not null
, no_dispatch boolean default false not null
, initialized boolean default false not null
, create_time timestamp without time zone not null
);

insert into strload_streams_new
select
    stream_id
    , stream_name
    , table_id
    , disabled
    , discard
    , no_dispatch
    , true as initialized
    , now() as create_time
from strload_streams
;

begin;
    alter table strload_streams rename to strload_streams_old;
    alter table strload_streams_new rename to strload_streams;

    alter index strload_streams_pkey rename to strload_streams_old_pkey;
    alter index strload_streams_stream_name_idx rename to strload_streams_old_stream_name_idx;
    alter index strload_streams_table_id_idx rename to strload_streams_old_table_id_idx;

    alter index strload_streams_new_pkey rename to strload_streams_pkey;
    create index strload_streams_table_id_idx on strload_streams using btree (table_id);
    create unique index strload_streams_stream_name_idx on strload_streams using btree (stream_name);

    alter table strload_streams_stream_id_seq rename to strload_streams_old_stream_id_seq;
    alter table strload_streams_new_stream_id_seq rename to strload_streams_stream_id_seq;
    select setval('strload_streams_stream_id_seq', (select last_value from strload_streams_old_stream_id_seq));
commit;
