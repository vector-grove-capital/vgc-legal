---
layout: default
title: Home
description: Vector Grove builds focused Jira apps that run entirely on Atlassian's Forge platform. No external servers, no third-party API keys, no data leaving Atlassian infrastructure.
---

<div class="hero" markdown="1">

<p class="eyebrow">Jira apps, built on Forge</p>

# Your data never leaves Atlassian.

<p class="standfirst">Vector Grove builds small, sharp Jira apps that turn information Jira already
has into ordinary, searchable fields. Two apps, each doing one thing completely.</p>

<div class="claim" markdown="1">
Both apps run **entirely on Atlassian's Forge platform**. There are no Vector Grove
servers, no third-party services, no API keys to hand over, and no data leaving
Atlassian infrastructure &mdash; because there is nowhere for it to go.
</div>

</div>

## The apps

<div class="cards">
  <div class="card">
    <h3>Sprint Dates for Jira</h3>
    <p class="price">Sprint start and end dates as real, searchable fields</p>
    <p>Jira knows when every sprint starts and ends &mdash; it just will not let you
    search by it. This adds <strong>Sprint Start Date</strong> and
    <strong>Sprint End Date</strong> to every work item in a sprint, as ordinary
    indexed Jira date fields.</p>
    <a class="card-link" href="{{ '/apps/sprint-dates/' | relative_url }}">How it works</a>
  </div>
  <div class="card">
    <h3>Test Coverage for Jira</h3>
    <p class="price">Which requirements have tests? Ask Jira, in JQL</p>
    <p>Your test management app knows which work items have tests. Jira does not.
    This adds <strong>Test Coverage</strong> and <strong>Linked Test Count</strong>
    as ordinary indexed Jira fields, computed from the links already in your site.</p>
    <a class="card-link" href="{{ '/apps/test-coverage/' | relative_url }}">How it works</a>
  </div>
</div>

<div class="note" markdown="1">
**Marketplace status.** Both apps are in final preparation for listing on the
Atlassian Marketplace. This page will carry the listing links once they are live.
</div>

## One idea, applied twice

Jira's search is the most powerful thing in the product, and it can only see fields.
Anything that is not a field &mdash; a sprint's schedule, a link to a test &mdash; can at
best be dug out with a search: it can never be a navigator column, never be sorted on,
and never land in a CSV export.

Both apps do the same thing about it: take something Jira already knows, and publish it
as a real, indexed field.

```
"Sprint End Date" <= endOfMonth() AND status != Done
"Test Coverage" = "Not covered" AND status != Done AND fixVersion = "3.2"
```

Because the results are ordinary Jira fields, they work everywhere ordinary fields
work: JQL, saved filters, navigator columns and sorting, and CSV export.

## Why "runs on Atlassian" matters

Many Jira apps that add fields do that work on the vendor's own servers. When they do,
your issue data leaves Atlassian, sits in someone else's database, and your security
review has to account for it.

Neither of these apps can do that. They are Forge apps with no egress permissions at
all, so the platform itself &mdash; not a promise in a privacy policy &mdash; is what
stops data from leaving.

[What each app stores, exactly]({{ '/security/' | relative_url }})

## Pricing

Both apps are **free on Jira sites of 10 users or fewer**. That is Atlassian's rule for
Marketplace apps, not a trial. Above that, each is priced per user per month with the
rate falling as your site grows; the current rates are shown on the Marketplace listing,
which is the only place they are ever binding.

## Support

Bug reports, questions and feature requests go to the public
[issue tracker]({{ site.github_issues }}). We aim to respond within two business days.
More detail on [the support page]({{ '/support/' | relative_url }}).
