# Intelligence Layer — Design With Richard

## Messy inputs Richard provides
- Raw article body (long prose, no tags, no summary)
- Framework description (informal notes)
- Enquiry messages (unstructured visitor text)

## Auto-structure schema (article example)
```json
{
  "ai_summary": "Short 2-sentence plain-English summary of the article",
  "ai_summary_source": "openai/gpt-4o",
  "ai_summary_confidence": 0.91,
  "ai_summary_review_status": "unreviewed",
  "ai_tags": ["life design", "clarity", "frameworks"],
  "ai_tags_source": "openai/gpt-4o",
  "ai_tags_confidence": 0.85,
  "ai_tags_review_status": "unreviewed"
}
```

## Events to track
- Article published (with word count, category)
- Framework downloaded (with visitor email if provided)
- Enquiry submitted (type, area of interest)
- Subscriber opted in (source page)

## Scoring rules (rule-based v1)
- **Lead warmth score** = `enquiry_type == 'coaching' ? +3 : 0` + `preferred_date set ? +2 : 0` + `area_of_interest matches published content ? +1 : 0`
- **Popular content** = `view_count` rank descending (articles), `download_count` rank descending (frameworks)

## v1 vs Later
**v1:** Rule-based lead warmth score; download/view counters; manual tag entry.
**Later:** AI auto-tagging and SEO suggestions on save (low-risk, auto-applied after Richard reviews); enquiry intent classification; content gap suggestions based on subscriber interests.
