-- Control de Unidades: tablas en Supabase. Pegar completo en SQL Editor → Run.
create table if not exists public.registros (
  owner uuid not null default auth.uid() references auth.users on delete cascade,
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (owner, id)
);
create table if not exists public.comprobantes (
  owner uuid not null default auth.uid() references auth.users on delete cascade,
  id text not null,
  data text not null,
  primary key (owner, id)
);
alter table public.registros enable row level security;
alter table public.comprobantes enable row level security;
create policy "solo el dueno" on public.registros for all using (auth.uid() = owner) with check (auth.uid() = owner);
create policy "solo el dueno" on public.comprobantes for all using (auth.uid() = owner) with check (auth.uid() = owner);
alter publication supabase_realtime add table public.registros;
