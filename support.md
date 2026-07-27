---
layout: default
permalink: /support/
title: Support
heading: Support
standfirst: One public tracker, a two-business-day response target, and an honest account of what we can and cannot see.
description: How to get help with Vector Grove's Jira apps, what to include in a report, and what the support commitment actually is.
---

## Where to raise something

**[The public issue tracker]({{ site.github_issues }})** &mdash; bug reports, questions
and feature requests all go to the same place. It is public deliberately: an answer that
helps you usually helps the next person with the same question.

If a report would expose something about your instance that you would rather not
publish, say so in the issue without the detail and a private channel will be arranged.

## Response commitment

| | |
|---|---|
| First response | Within **two business days** |
| Business days | Monday to Friday, US Central time, excluding US public holidays |
| Critical issues | An app writing wrong values, or not writing them at all, is treated as critical and jumps the queue |

A first response means a human has read it and told you what happens next &mdash; not
that it is fixed. Fix time depends on what the fault turns out to be.

## What to include

**We cannot see your data.** The apps run entirely inside your Atlassian tenancy with no
outbound connection, so there is no log on our side to check. Everything we know about a
problem is what you tell us. The reports that get solved fastest carry:

1. Which app, and what you expected to happen.
2. The exact JQL, if it is a search or sort problem &mdash; pasted, not described.
3. A work item key, and what its fields show versus what they should show.
4. Whether the work item recently changed sprint, or had a link added or removed, and
   roughly how long ago.

That last one matters more than it looks. Both apps have a fast path and a slow path:

- **Within seconds** &mdash; a work item changing sprint (Sprint Dates), or a test link
  being added or removed (Test Coverage).
- **Within the hour** &mdash; a sprint's schedule changing, a sprint being started, a
  linked test work item being deleted. Jira raises no event for these, so an hourly
  reconciliation catches them.

If a value looks wrong and the change was one of the second group, waiting for the next
hourly sweep is the first thing to try.

## Known limits, stated up front

- **No pass/fail in Test Coverage.** Coverage means a linked test *exists*. Whether it
  passed lives in your test management app's backend, which a no-egress app cannot
  reach. See [the app page]({{ '/apps/test-coverage/' | relative_url }}).
- **Board columns and dashboard gadgets are unverified.** The fields are ordinary
  indexed Jira fields and may well work there; we have not confirmed it, so we do not
  claim it.
- **Free on sites of 10 users or fewer.** That is Atlassian's rule, and support applies
  the same way on free installs as on paid ones.

## Feature requests

Welcome, and the tracker is the right place. Both apps are deliberately narrow &mdash;
each does one thing completely rather than several things partly &mdash; so a request
that would broaden an app's remit may be declined, and will be declined openly with the
reason rather than left to go quiet.
