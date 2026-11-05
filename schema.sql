-- À exécuter dans le SQL Editor du NOUVEAU projet Retour client.
-- Accès réservé aux comptes explicitement autorisés ci-dessous.
begin;
create table public.rc_staff (
 user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.rc_staff enable row level security;
revoke all on public.rc_staff from anon, authenticated;
grant select on public.rc_staff to authenticated;
create policy staff_self on public.rc_staff for select to authenticated using(user_id=(select auth.uid()));
create table public.rc_responses (
 id uuid primary key,
 created_at timestamptz not null default now(),
 outcome text not null check(outcome in ('response','refusal')),
 service text not null check(service in ('Midi','Soir')),
 first text check(first in ('Oui','Non')),
 source text check(source in ('Bouche-à-oreille','En passant','Google ou Maps','Réseaux sociaux','Autre')),
 reasons text[],
 primary_reason text,
 food text check(food in ('Très satisfait','Satisfait','Mitigé','Insatisfait','Non concerné')),
 service_rating text check(service_rating in ('Très satisfait','Satisfait','Mitigé','Insatisfait','Non concerné')),
 atmosphere text check(atmosphere in ('Très satisfait','Satisfait','Mitigé','Insatisfait','Non concerné')),
 value text check(value in ('Très satisfait','Satisfait','Mitigé','Insatisfait','Non concerné')),
 return_intent text check(return_intent in ('Oui','Peut-être','Non')),
 improvement text check(improvement in ('Cuisine','Service','Attente','Ambiance ou bruit','Prix','Rien en particulier','Autre')),
 comment text check(length(comment)<=1000),
 check(outcome='refusal' or (first is not null and (first='Non' or source is not null) and cardinality(reasons)>0 and primary_reason is not null and primary_reason=any(reasons) and food is not null and service_rating is not null and atmosphere is not null and value is not null and return_intent is not null and improvement is not null)),
 check(reasons <@ array['Pizzas','Autres spécialités italiennes','Ambiance et cadre','Histoire du restaurant','Emplacement','Habitude','Invitation d’un proche','Autre']::text[])
);
create index rc_responses_date on public.rc_responses(created_at desc);
alter table public.rc_responses enable row level security;
revoke all on public.rc_responses from anon,authenticated;
grant select,insert on public.rc_responses to authenticated;
create policy staff_read on public.rc_responses for select to authenticated using(exists(select 1 from public.rc_staff where user_id=(select auth.uid())));
create policy staff_insert on public.rc_responses for insert to authenticated with check(exists(select 1 from public.rc_staff where user_id=(select auth.uid())));
commit;
-- Après création du compte dans Authentication > Users, autoriser son UUID :
-- insert into public.rc_staff(user_id) values ('UUID_DU_COMPTE');
-- Révoquer cet accès : delete from public.rc_staff where user_id='UUID_DU_COMPTE';
