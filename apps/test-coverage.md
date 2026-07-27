---
layout: default
permalink: /apps/test-coverage/
title: Test Coverage for Jira
heading: Test Coverage for Jira
standfirst: Linked test count and coverage status as real, searchable Jira fields. Works alongside Xray, Zephyr, and any team convention that ends in "Test".
description: Test Coverage adds Test Coverage and Linked Test Count as ordinary indexed Jira fields, computed from the Jira issue graph rather than a vendor backend.
---

Your test management app knows which work items have tests. Jira does not.

That gap is why "show me every unfinished story with no test" is a question you answer
by hand. Test Coverage adds two ordinary, indexed Jira fields to every work item that
has links:

- **Test Coverage** &mdash; `Covered` or `Not covered`
- **Linked Test Count** &mdash; how many Test work items are linked to it

```
"Test Coverage" = "Not covered" AND status != Done AND fixVersion = "3.2"
"Linked Test Count" = 0 AND type = Story AND sprint in openSprints()
ORDER BY "Linked Test Count" DESC
```

<figure class="shot">
  <img src="{{ '/assets/img/test-coverage-search.png' | relative_url }}"
       alt="Jira work item search with Test Coverage and Linked Test Count as columns, sorted by linked test count descending, showing Covered and Not covered values."
       width="1840" height="900" loading="lazy">
  <figcaption>Coverage status and linked test count as navigator columns, sorted by count.
  Both are ordinary indexed fields, so the sort is on the value.</figcaption>
</figure>

## Where the fields work

| Surface | Supported |
|---|---|
| JQL search, including numeric ranges | Yes |
| Sorting (`ORDER BY`) by real value | Yes |
| Saved filters | Yes |
| Navigator columns | Yes |
| CSV export | Yes |
| On the work item itself | Yes, in the context column |

Board columns and dashboard gadgets are not claimed here either, for the same reason:
they have not been verified.

<figure class="shot">
  <img src="{{ '/assets/img/test-coverage-work-item.png' | relative_url }}"
       alt="A Jira work item showing the Test Coverage panel in the context column, reading COVERED with two linked Test work items, beside the linked tests themselves."
       width="1840" height="900" loading="lazy">
  <figcaption>On the work item: coverage status, the number of linked tests, and the tests
  themselves in the links section. The <code>DEV</code> badge is Jira marking an app
  installed from a development environment; it does not appear on a Marketplace install.</figcaption>
</figure>

## Works with your test management app &mdash; and after it

Coverage is computed from the Jira issue graph. Any linked work item whose **type** name
ends in "Test" counts: Xray's `Xray Test`, Zephyr's tests, and a team's own
`Manual Test` all qualify, in either link direction, whatever the link type is called.

It deliberately does **not** count `Test Set`, `Test Plan`, `Test Execution`,
`Sub Test Execution` or `Precondition`. Over-reporting coverage is worse than
under-reporting it, because it tells someone it is safe to ship.

Because it reads Jira rather than a vendor's backend, it keeps working if you migrate
between test management apps, or stop using one entirely. Your Test work items stay in
Jira, so your coverage fields stay correct.

## What it does not do

Stated plainly, because a surprise here would earn a one-star review.

- **No pass/fail.** Whether a test *passed* lives in your test management app's own
  backend &mdash; Xray's Test Runs are not Jira links &mdash; and reaching it would
  need egress and your API credentials. This app is deliberately no-egress. Coverage
  means a test *exists* and is linked, not that it passed.
- **No test authoring, execution or reporting.** It is a companion to your test
  management app, not a replacement for one.
- **Only linked work items are scored.** A work item with no links at all is left blank
  rather than marked `Not covered`, because an item never meant to carry tests is not a
  coverage gap.

## How the fields stay correct

Link or unlink a test and the fields update within seconds. An hourly reconciliation
repairs anything that drifts &mdash; including cases Jira raises no event for, such as
a linked Test work item being deleted outright.

## What it stores

Work item links and work item types, read at the moment coverage is computed. It never
reads summaries, descriptions, comments or attachments, and it never contacts a
third-party service. Full detail on the
[security and data page]({{ '/security/' | relative_url }}).

## Pricing

Free on Jira sites of 10 users or fewer, per Atlassian's Marketplace rules. Above that,
per user per month, with the rate falling as the site grows. The Marketplace listing
carries the binding rates.

## Support

Questions and bug reports: [issue tracker]({{ site.github_issues }}).
See the [support page]({{ '/support/' | relative_url }}) for what to include.
