create table if not exists content_categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  slug text not null unique,
  description text
);
alter table content_categories enable row level security;
drop policy if exists "content_categories_v1_read" on content_categories;
create policy "content_categories_v1_read" on content_categories for select using (true);
drop policy if exists "content_categories_v1_write" on content_categories;
create policy "content_categories_v1_write" on content_categories for all using (true) with check (true);

create table if not exists articles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  slug text not null unique,
  body text,
  excerpt text,
  featured_image_url text,
  status text not null default 'draft',
  category_id uuid references content_categories(id),
  published_at timestamptz,
  read_time_minutes int,
  tags text[],
  seo_title text,
  seo_description text,
  view_count int not null default 0,
  ai_summary text,
  ai_summary_source text,
  ai_summary_confidence numeric,
  ai_summary_review_status text default 'unreviewed',
  ai_tags text[],
  ai_tags_source text,
  ai_tags_confidence numeric,
  ai_tags_review_status text default 'unreviewed'
);
alter table articles enable row level security;
drop policy if exists "articles_v1_read" on articles;
create policy "articles_v1_read" on articles for select using (true);
drop policy if exists "articles_v1_write" on articles;
create policy "articles_v1_write" on articles for all using (true) with check (true);

create table if not exists frameworks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  slug text not null unique,
  description text,
  body text,
  file_url text,
  preview_image_url text,
  status text not null default 'draft',
  category_id uuid references content_categories(id),
  download_count int not null default 0,
  tags text[],
  published_at timestamptz
);
alter table frameworks enable row level security;
drop policy if exists "frameworks_v1_read" on frameworks;
create policy "frameworks_v1_read" on frameworks for select using (true);
drop policy if exists "frameworks_v1_write" on frameworks;
create policy "frameworks_v1_write" on frameworks for all using (true) with check (true);

create table if not exists masterclasses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  title text not null,
  slug text not null unique,
  description text,
  body text,
  status text not null default 'draft',
  event_date timestamptz,
  duration_minutes int,
  format text,
  featured_image_url text,
  registration_url text,
  capacity int,
  category_id uuid references content_categories(id),
  published_at timestamptz
);
alter table masterclasses enable row level security;
drop policy if exists "masterclasses_v1_read" on masterclasses;
create policy "masterclasses_v1_read" on masterclasses for select using (true);
drop policy if exists "masterclasses_v1_write" on masterclasses;
create policy "masterclasses_v1_write" on masterclasses for all using (true) with check (true);

create table if not exists enquiries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  email text not null,
  phone text,
  message text,
  area_of_interest text,
  enquiry_type text not null default 'general',
  preferred_date timestamptz,
  status text not null default 'unread',
  admin_note text,
  source_page text
);
alter table enquiries enable row level security;
drop policy if exists "enquiries_v1_read" on enquiries;
create policy "enquiries_v1_read" on enquiries for select using (true);
drop policy if exists "enquiries_v1_write" on enquiries;
create policy "enquiries_v1_write" on enquiries for all using (true) with check (true);

create table if not exists subscribers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text,
  email text not null unique,
  status text not null default 'active',
  source text,
  area_of_interest text,
  tags text[]
);
alter table subscribers enable row level security;
drop policy if exists "subscribers_v1_read" on subscribers;
create policy "subscribers_v1_read" on subscribers for select using (true);
drop policy if exists "subscribers_v1_write" on subscribers;
create policy "subscribers_v1_write" on subscribers for all using (true) with check (true);

create table if not exists testimonials (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  author_name text not null,
  author_title text,
  author_photo_url text,
  body text not null,
  area_of_life text,
  status text not null default 'draft',
  featured boolean not null default false,
  sort_order int not null default 0
);
alter table testimonials enable row level security;
drop policy if exists "testimonials_v1_read" on testimonials;
create policy "testimonials_v1_read" on testimonials for select using (true);
drop policy if exists "testimonials_v1_write" on testimonials;
create policy "testimonials_v1_write" on testimonials for all using (true) with check (true);

create table if not exists resource_downloads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  framework_id uuid references frameworks(id),
  visitor_email text,
  visitor_name text,
  ip_hash text
);
alter table resource_downloads enable row level security;
drop policy if exists "resource_downloads_v1_read" on resource_downloads;
create policy "resource_downloads_v1_read" on resource_downloads for select using (true);
drop policy if exists "resource_downloads_v1_write" on resource_downloads;
create policy "resource_downloads_v1_write" on resource_downloads for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  action text not null,
  object_type text not null,
  object_id uuid,
  payload jsonb,
  risk_level text not null default 'low'
);
alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into content_categories (id, name, slug, description) values
  (gen_random_uuid(), 'Life Design', 'life-design', 'Frameworks and articles on designing your ideal life'),
  (gen_random_uuid(), 'Career & Business', 'career-business', 'Strategic thinking for career and business growth'),
  (gen_random_uuid(), 'Health & Wellbeing', 'health-wellbeing', 'Designing sustainable health habits and mindset'),
  (gen_random_uuid(), 'Wealth & Legacy', 'wealth-legacy', 'Building lasting wealth and a meaningful legacy')
on conflict do nothing;

insert into articles (title, slug, body, excerpt, status, published_at, read_time_minutes, tags) values
  ('Design Your Life Like an Architect', 'design-your-life-like-an-architect', 'Most people drift through life reacting to whatever comes next. Architects don''t build that way — they start with a blueprint. In this article I share the five foundational principles I use with executives and entrepreneurs to design a life with intention, clarity and purpose.', 'Most people drift through life reacting. Architects don''t — they start with a blueprint. Here are the five principles that change everything.', 'published', now() - interval '7 days', 6, ARRAY['life design', 'clarity', 'purpose']),
  ('The Six Domains of a Designed Life', 'six-domains-of-a-designed-life', 'True life design isn''t just about career or money. It spans six domains: Health, Career, Business, Relationships, Wealth and Legacy. When one domain is neglected, the whole structure weakens. Here''s how to audit all six and find your leverage points.', 'True life design spans six domains. When one is neglected, the whole structure weakens — here''s how to audit them.', 'published', now() - interval '3 days', 8, ARRAY['frameworks', 'life design', 'six domains']),
  ('Why Most Professionals Plateau — and How to Break Through', 'why-professionals-plateau', 'After a certain level of success, the same habits that got you here will keep you stuck. I call this the Competence Ceiling. This article explains the pattern and the architectural shift needed to move beyond it.', 'The same habits that got you here will keep you stuck. Here''s the architectural shift needed to break through.', 'published', now() - interval '1 day', 5, ARRAY['career', 'growth', 'mindset'])
on conflict do nothing;

insert into frameworks (title, slug, description, status, download_count, tags, published_at) values
  ('Life Blueprint Canvas', 'life-blueprint-canvas', 'A one-page visual tool for mapping your ideal life across all six domains. Used in Richard''s flagship workshops and one-to-one coaching engagements.', 'published', 47, ARRAY['canvas', 'life design', 'tool'], now() - interval '14 days'),
  ('The 90-Day Life Architecture Sprint', '90-day-life-architecture-sprint', 'A structured 12-week planning worksheet that helps you translate your life vision into weekly actions — with built-in review checkpoints.', 'published', 23, ARRAY['planning', 'productivity', 'worksheet'], now() - interval '10 days'),
  ('Career Leverage Audit', 'career-leverage-audit', 'A diagnostic worksheet for identifying the highest-leverage moves in your career or business right now. Pinpoints strengths, gaps and next actions.', 'published', 18, ARRAY['career', 'audit', 'worksheet'], now() - interval '5 days')
on conflict do nothing;

insert into masterclasses (title, slug, description, status, format, event_date, duration_minutes, published_at) values
  ('Design Your Life Masterclass — Foundations', 'design-your-life-masterclass-foundations', 'A 90-minute live session introducing the Life Architect methodology. Ideal for professionals feeling stuck or ready for a purposeful reset. Includes Q&A and a downloadable workbook.', 'published', 'Live Online', now() + interval '21 days', 90, now() - interval '2 days'),
  ('From Burnout to Blueprint', 'from-burnout-to-blueprint', 'A focused workshop for executives and high-performers who have achieved success but lost meaning. Covers the six-domain audit and 90-day reset plan.', 'published', 'Live Online', now() + interval '35 days', 120, now() - interval '1 day')
on conflict do nothing;

insert into testimonials (author_name, author_title, body, area_of_life, status, featured, sort_order) values
  ('Sandra K.', 'CFO, Financial Services', 'Richard''s Life Blueprint process gave me clarity I hadn''t felt in years. Within six weeks I restructured my schedule, renegotiated two major commitments and finally started the health habits I''d been putting off for a decade.', 'Life Design', 'published', true, 1),
  ('Marcus T.', 'Founder, Technology Consultancy', 'I came in thinking I needed a business strategy. What I actually needed was a life strategy. Richard helped me see the difference — and design both.', 'Career & Business', 'published', true, 2),
  ('Priya R.', 'Retired Executive & Educator', 'Retirement felt like a blank page — exciting but overwhelming. Richard''s framework helped me design the next chapter with purpose and real momentum.', 'Legacy', 'published', true, 3)
on conflict do nothing;