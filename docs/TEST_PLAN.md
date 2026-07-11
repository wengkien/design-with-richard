# Test Plan — Design With Richard

## v1 Success Scenario (manual walkthrough)

### 1. Publish an article (admin)
1. Open `/admin/articles/new`
2. Enter title "Design Your Legacy", paste body text, set status to Published, pick a category
3. Click Save
4. **Pass:** Redirected to article list; "Design Your Legacy" appears with Published badge
5. Open `/` in a new incognito tab
6. **Pass:** Article appears in the published articles grid

### 2. Download a framework (public visitor)
1. Open `/frameworks/life-blueprint-canvas` without logging in
2. Click Download
3. Enter name and email in the gate form; submit
4. **Pass:** PDF download begins (signed URL); `resource_downloads` row exists in Supabase; `frameworks.download_count` incremented by 1

### 3. Submit an enquiry (public visitor)
1. Open `/contact`
2. Fill in name, email, message, select area_of_interest = "Life Design", type = "coaching", set a preferred date
3. Submit
4. **Pass:** Success message shown; `enquiries` row exists with `status = 'unread'`
5. Open `/admin/enquiries` — **Pass:** New row appears with Unread badge
6. Click row → mark as Read, add admin note → Save
7. **Pass:** Status updated to "read"; note persists on page refresh

## Empty / error cases
| Scenario | Expected |
|---|---|
| Admin article list — no articles yet | Empty state: "No articles yet. Create your first one." with a New Article button |
| Contact form submitted with empty email | Inline validation error on email field; no database insert |
| Framework file_url missing | Download button shows "File not available"; no resource_downloads row written |
| Supabase unreachable | Error banner: "Could not load content. Please try again." — no crash |
| Duplicate article slug | Server Action returns error: "A post with this slug already exists"; form stays open |
| Enquiry list viewed while logged out (Sprint 5+) | Returns empty array (RLS blocks row); admin UI shows login redirect |

## Scope note
Payment flows, email send, AI suggestions and multi-user access are out of scope for this test plan.
