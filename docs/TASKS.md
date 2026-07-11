# Tasks & Sprints — Design With Richard

## Sprint 1 — Database & core content engine
**Goal:** Content tables exist; Richard can create, edit and publish an Article, Framework and Masterclass through the admin UI. Public homepage renders seeded content without login.

- [ ] Run and verify migration SQL (all tables, RLS v1 policies, seed data)
- [ ] `/admin/articles` — list view with status badges
- [ ] `/admin/articles/new` and `/admin/articles/[id]/edit` — form with title, slug (auto), body (rich text), excerpt, status, category, tags, featured image URL
- [ ] Server Action: insert/update article row; validate required fields; return error if slug conflict
- [ ] `/admin/frameworks` — list, new, edit (title, description, file_url, status, download_count read-only)
- [ ] `/admin/masterclasses` — list, new, edit (title, description, event_date, format, status)
- [ ] Public `/` — hero, published articles grid, frameworks list, upcoming masterclasses
- [ ] All five UI states: loading skeleton, empty state with "No content yet", partial list, error banner, ready
- [ ] Delete action on all three content types (writes audit_log row, confirms before executing)

**Definition of Done:** Create a new article in admin → set status to Published → visit `/` as anonymous → article appears in the grid. Confirmed by a manual browser test.

---

## Sprint 2 — Public site & resource downloads
**Goal:** Full public website is navigable; framework download is tracked end-to-end.

- [ ] `/articles` listing page and `/articles/[slug]` detail page (view_count increment on load)
- [ ] `/frameworks` listing and `/frameworks/[slug]` detail with Download button
- [ ] Download button: inserts `resource_downloads` row + increments `frameworks.download_count` via Server Action
- [ ] Signed URL served for PDF download (Supabase Storage)
- [ ] `/masterclasses` listing and `/masterclasses/[slug]` detail
- [ ] `/about` and `/services` static pages with Richard's methodology copy
- [ ] Contact enquiry form (`/contact`): name, email, message, area_of_interest, enquiry_type → inserts to `enquiries`
- [ ] Form: success state, validation error state, submission error state
- [ ] Navigation header and footer on all public pages

**Definition of Done:** Anonymous visitor navigates to a framework page, clicks Download, enters email, receives the PDF — `resource_downloads` row exists and `download_count` incremented. Enquiry form submits and row appears in Supabase.

---

## Sprint 3 — Leads, subscribers & admin inbox ✦ v1 functional milestone
**Goal:** Richard can see and act on all incoming enquiries and subscribers without leaving the platform.

- [ ] Email opt-in widget (name + email) on homepage and article detail pages → inserts to `subscribers`
- [ ] `/admin/subscribers` — list with name, email, source, created_at, area_of_interest
- [ ] `/admin/enquiries` — list with status badge (unread/read/actioned), name, email, type, created_at
- [ ] Enquiry detail view: full message, area_of_interest, preferred_date, admin_note field (save updates row)
- [ ] Mark enquiry as read/actioned (status update Server Action)
- [ ] `/admin/testimonials` — CRUD (create, edit, publish, delete, reorder sort_order)
- [ ] Public homepage testimonials section (featured = true, status = published)
- [ ] Coaching request form variant (`enquiry_type = 'coaching'`, adds preferred_date field)

**Definition of Done:** Visitor submits coaching enquiry → Richard opens admin inbox → sees unread badge → marks as actioned and saves a note → refreshes page → status and note persist.

---

## Sprint 4 — Polish, branding & SEO
**Goal:** Site reflects Richard's professional brand; every public page is share-ready.

- [ ] Apply brand tokens: primary colour, typography, logo/wordmark in layout
- [ ] Meta `<title>`, `<meta name="description">`, Open Graph tags on every public page (use `seo_title` / `seo_description` from article row if set)
- [ ] Responsive layout verified at 375px, 768px and 1280px
- [ ] Favicon, custom 404 page, React error boundary
- [ ] Copy review: all button labels, empty states and headings match Richard's voice
- [ ] Admin dashboard `/admin` — summary cards: total published articles, frameworks, enquiries (unread count), subscribers

**Definition of Done:** Share an article URL on a mobile device; OG preview shows correct title and image. Resize browser to 375px — no horizontal scroll on any public page.

---

## Sprint 5 — Lock it down
**Goal:** Admin is protected by login; public content remains open; no sensitive data leaks.

- [ ] Enable Supabase Auth; create Richard's admin account
- [ ] `/login` page with email + password form
- [ ] Middleware: redirect `/admin/*` to `/login` if no session
- [ ] Replace v1 open write policies with `auth.uid() = user_id` on articles, frameworks, masterclasses, enquiries, subscribers, testimonials, resource_downloads, audit_logs
- [ ] Enquiries and subscribers `SELECT` policy: `auth.uid() = user_id` (not public)
- [ ] Public SELECT policies on articles/frameworks/masterclasses/testimonials remain open
- [ ] Set `user_id` on all new rows from `auth.uid()` server-side
- [ ] Logout button in admin nav
- [ ] Confirm no Supabase service key in any client bundle (Vercel env check)

**Definition of Done:** Log out → `/admin/articles` redirects to `/login`. Log back in → articles list loads. Visit `/articles` as anonymous → published articles visible. Enquiries list returns 0 rows to an unauthenticated Supabase query.

---

## Gantt (sprint landing)
```
Sprint 1 | DB + content CRUD + public homepage
Sprint 2 | Public site + downloads + enquiry form
Sprint 3 | Subscriber + inbox + testimonials  ← v1 functional
Sprint 4 | Brand + SEO + responsive polish
Sprint 5 | Auth + RLS lock-down
```
