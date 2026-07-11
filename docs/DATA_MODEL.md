# Data Model — Design With Richard

## content_categories
`id`, `user_id`, `created_at`, `name:text`, `slug:text unique`, `description:text`

## articles
`id`, `user_id`, `created_at`, `title:text`, `slug:text unique`, `body:text`, `excerpt:text`, `featured_image_url:text`, `status:text` (draft|published|archived), `category_id → content_categories`, `published_at:timestamptz`, `read_time_minutes:int`, `tags:text[]`, `seo_title:text`, `seo_description:text`, `view_count:int default 0`
**AI fields:** `ai_summary`, `ai_summary_source`, `ai_summary_confidence`, `ai_summary_review_status` | `ai_tags`, `ai_tags_source`, `ai_tags_confidence`, `ai_tags_review_status`

## frameworks
`id`, `user_id`, `created_at`, `title:text`, `slug:text unique`, `description:text`, `body:text`, `file_url:text`, `preview_image_url:text`, `status:text`, `category_id → content_categories`, `download_count:int default 0`, `tags:text[]`, `published_at:timestamptz`

## masterclasses
`id`, `user_id`, `created_at`, `title:text`, `slug:text unique`, `description:text`, `body:text`, `status:text`, `event_date:timestamptz`, `duration_minutes:int`, `format:text`, `featured_image_url:text`, `registration_url:text`, `capacity:int`, `category_id → content_categories`, `published_at:timestamptz`

## enquiries
`id`, `user_id`, `created_at`, `name:text`, `email:text`, `phone:text`, `message:text`, `area_of_interest:text`, `enquiry_type:text` (general|coaching|masterclass), `preferred_date:timestamptz`, `status:text` (unread|read|actioned), `admin_note:text`, `source_page:text`

## subscribers
`id`, `user_id`, `created_at`, `name:text`, `email:text unique`, `status:text` (active|unsubscribed), `source:text`, `area_of_interest:text`, `tags:text[]`

## testimonials
`id`, `user_id`, `created_at`, `author_name:text`, `author_title:text`, `author_photo_url:text`, `body:text`, `area_of_life:text`, `status:text` (draft|published), `featured:boolean`, `sort_order:int`

## resource_downloads
`id`, `user_id`, `created_at`, `framework_id → frameworks`, `visitor_email:text`, `visitor_name:text`, `ip_hash:text`

## audit_logs
`id`, `user_id`, `created_at`, `action:text`, `object_type:text`, `object_id:uuid`, `payload:jsonb`, `risk_level:text` (low|medium|high|critical)

## RLS (v1)
All tables: permissive select + write for anonymous (demo-first). Sprint 5 replaces write policies with `auth.uid() = user_id` for admin tables; public read on articles/frameworks/masterclasses/testimonials stays open.
