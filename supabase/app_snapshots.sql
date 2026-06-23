create table if not exists public.app_snapshots (
  id text primary key,
  app_name text not null,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default timezone('utc', now()),
  updated_by text
);

alter table public.app_snapshots enable row level security;

create or replace function public.touch_app_snapshots_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

drop trigger if exists set_app_snapshots_updated_at on public.app_snapshots;
create trigger set_app_snapshots_updated_at
before update on public.app_snapshots
for each row
execute function public.touch_app_snapshots_updated_at();

drop policy if exists "Public can read app snapshots" on public.app_snapshots;
create policy "Public can read app snapshots"
on public.app_snapshots
for select
to anon, authenticated
using (true);

drop policy if exists "Public can insert app snapshots" on public.app_snapshots;
create policy "Public can insert app snapshots"
on public.app_snapshots
for insert
to anon, authenticated
with check (true);

drop policy if exists "Public can update app snapshots" on public.app_snapshots;
create policy "Public can update app snapshots"
on public.app_snapshots
for update
to anon, authenticated
using (true)
with check (true);
