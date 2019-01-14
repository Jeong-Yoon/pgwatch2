GRANT ALL ON SCHEMA public TO pgwatch2;

SET ROLE TO pgwatch2;

-- drop table if exists public.storage_schema_type;

/* although the gather has a "--pg-storage-type" param, the WebUI might not know about it in a custom setup */
create table public.storage_schema_type (
  schema_type text not null,
  initialized_on timestamptz not null default now(),
  check (schema_type in ('metric', 'metric-time', 'metric-dbname-time', 'custom'))
);

comment on table public.storage_schema_type is 'identifies storage schema for other pgwatch2 components';

create unique index max_one_row on public.storage_schema_type ((1));

/* for the Grafana drop-down. managed by the gatherer */
create table public.all_distinct_dbnames (
  dbname text not null,
  created_on timestamptz not null default now())
);


RESET ROLE;
