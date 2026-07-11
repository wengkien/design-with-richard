# Product Requirements — Design With Richard

## Problem
Richard Lim's Life Architect content (articles, frameworks, masterclasses, worksheets) is scattered across platforms he does not control. Publishing is manual and repetitive. Visitor enquiries have no central home. He needs a single owned platform to publish, manage and present his expertise — and capture audience interest.

## Target User
**Primary (admin):** Richard Lim — creates, edits and publishes all content.
**Secondary (public):** Professionals, executives, business owners and individuals exploring life design — they read, download and enquire.

## Core Objects
- **Article** — long-form content with status, category, tags, SEO fields
- **Framework** — downloadable worksheet/tool with file URL and download tracking
- **Masterclass** — upcoming or past live event with date, format and registration link
- **Content Category** — taxonomy shared across all content types
- **Enquiry** — visitor contact or coaching request
- **Subscriber** — email opt-in lead with area of interest
- **Testimonial** — success story displayed publicly
- **Resource Download** — log of each framework download event
- **Audit Log** — record of every meaningful admin action

## MVP Must-Haves
- [ ] Admin can create, edit, publish and delete Articles, Frameworks and Masterclasses
- [ ] Public homepage shows published content and brand methodology
- [ ] Public article detail page renders full body content
- [ ] Framework download button logs the event and increments download count
- [ ] Visitor can submit a contact / enquiry form (saved to database)
- [ ] Seed data makes the site look alive on first load without login

## Non-Goals (v1)
Payments, memberships, automated social posting, AI coaching, LMS, analytics dashboards, multilingual content, mobile app, live video hosting.

## Success Criteria
Richard opens the admin dashboard, creates a new article titled "Design Your Legacy", sets it to Published, then visits the public homepage as an anonymous visitor and sees the article live — without touching code or calling a developer. A visitor submits a contact enquiry and it appears in the admin inbox.
