# Architecture — Design With Richard

## Stack
- **Frontend:** Next.js 14 (App Router) — public site + /admin pages
- **Database:** Supabase (Postgres + RLS)
- **Auth (Sprint 5):** Supabase Auth — email/password for Richard only
- **Storage:** Supabase Storage — framework PDF uploads, featured images
- **Hosting:** Vercel — custom domain

## Now vs Later
**Now:** Content CRUD, public site, enquiry form, subscriber capture, resource download tracking.
**Later:** Email send, scheduled publishing, AI tagging/SEO suggestions, payment-linked registrations, analytics.

## Key Action — Publish an Article (end-to-end)
1. Richard fills in the article form in `/admin/articles/new`
2. On submit, the Next.js Server Action validates and `INSERT`s a row into `articles` with `status = 'published'`
3. Supabase returns the new row; the admin redirects to the article list with a success toast
4. The public `/articles/[slug]` page fetches from Supabase (server component) — anonymous read allowed by v1 RLS policy
5. Visitor sees the article; no login required

## Layer Plan
1. **Data** — tables, constraints, RLS (the ground truth; app logic reads/writes here)
2. **App logic** — Next.js Server Actions and API routes handle all mutations; no secrets in client components
3. **Smart features** (later) — AI tagging and SEO suggestions sit on top; if removed, publishing still works

## Why the core runs without AI
Every publish, edit and enquiry action is a direct database write. AI fields (`ai_summary`, `ai_tags`) are optional enrichment columns. The admin and public site function identically whether those fields are populated or not.
