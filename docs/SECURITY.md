# Security — Design With Richard

## Secrets
- `SUPABASE_SERVICE_ROLE_KEY` and `OPENAI_API_KEY` live in Vercel environment variables only — never imported into any client component or exposed in the browser bundle
- Public Supabase anon key is acceptable in the client (it is a known-public key gated by RLS)

## Permission model
**v1 (demo):** RLS open policies — any visitor can read all published content. Admin mutations use the same open policy until Sprint 5.
**Sprint 5 (lock-down):**
- Admin write paths require `auth.uid() = user_id` RLS policy
- `/admin/*` routes redirect to `/login` if no active session
- Public content (articles, frameworks, masterclasses, testimonials) retains open `SELECT` policy
- Enquiries and subscribers: `SELECT` restricted to authenticated owner

## Approved-tools rule
Server Actions and API routes call only the named tools listed in `AGENTIC_LAYER.md`. No route accepts a free-form function name or arbitrary SQL from the client.

## Audit principle
Every meaningful admin action (create, update, publish, delete attempt) writes a row to `audit_logs` with `user_id`, `action`, `object_type`, `object_id`, `payload` and `risk_level` before the action completes. Deletes are critical-level and blocked from agent execution.

## Data exposure
- Subscriber emails and enquiry details are never rendered in public-facing pages
- File URLs for framework PDFs are served via Supabase Storage signed URLs (short TTL) — not bare public links
- If in doubt about a security decision: stop and consult a qualified engineer before proceeding
