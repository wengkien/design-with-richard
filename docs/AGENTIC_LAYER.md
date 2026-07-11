# Agentic Layer — Design With Richard

## Risk levels and actions

### Low — auto-execute, log only
- Generate AI summary for a saved article
- Suggest tags for a new framework
- Increment `view_count` / `download_count` on page load / download click
- Auto-assign `read_time_minutes` from word count on article save

### Medium — draft shown to Richard for one-click approval
- Generate SEO title and description for an article (`seo_title`, `seo_description`)
- Suggest a category for a new piece of content
- Draft a follow-up note for an enquiry based on area of interest

### High — explicit approval required before execution
- Send a reply email to an enquiry
- Add a subscriber to an email campaign
- Publish content (status change from draft → published)

### Critical — human-only, no agent
- Delete any content or database row
- Export or download subscriber/enquiry list
- Change admin credentials

## Named tools (approved list)
- `generate_article_summary(article_id)` → writes `ai_summary` fields
- `suggest_tags(object_type, object_id)` → returns candidate tags for review
- `calculate_lead_score(enquiry_id)` → returns numeric score, no write
- `increment_download_count(framework_id)` → atomic counter update

## Audit log fields
`action`, `object_type`, `object_id`, `payload (before/after)`, `risk_level`, `user_id`, `created_at`

## v1 vs Later
**v1:** Only low-risk auto-actions (counters, read time). All others logged but not executed by agent.
**Later:** Medium-risk drafting with Richard's one-click approval; email send with high-risk approval gate.
