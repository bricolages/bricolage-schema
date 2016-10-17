insert into strload_streams
    ( stream_id
    , stream_name
    , table_id
    , disabled
    , discard
    )
select
    pp.id as stream_id
    , pp.table_id as stream_name
    , st.table_id as table_id
    , pp.disabled
    , pp.discard
from
    preproc_tables pp
    left outer join strload_tables st on pp.table_id = st.data_source_id
;
