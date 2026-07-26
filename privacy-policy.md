---
title: Privacy Policy
---

# Privacy Policy

**Last updated:** 2026-07-25
**Provider:** Vector Grove Capital LLC
**Applies to:** Sprint Dates for Jira, Test Coverage for Jira

This policy describes what the Sprint Dates for Jira app ("the App") accesses,
stores, and transmits. It is written from the App's actual behaviour, not from a
template.

## Summary

The App runs entirely on Atlassian's Forge platform. **No data leaves Atlassian
infrastructure.** There are no external servers, no third-party services, and no
analytics. The provider cannot see your data.

## What the Apps access

**Sprint Dates for Jira** reads boards and sprints (names, ids, states, start and
end dates), which sprint a work item belongs to, and work item ids within a sprint.

**Test Coverage for Jira** reads work item types and the links between work items,
in order to count linked Test work items.

Neither App reads work item summaries, descriptions, comments, attachments, custom
field values belonging to other apps, or any user personal data. Neither accesses
Confluence, Bitbucket, or any other product.

## What the Apps write

Only the custom fields they define. Atlassian permits an app to write solely its
own fields, so neither App can modify any other field in your instance.

- **Sprint Dates for Jira** — Sprint Start Date, Sprint End Date
- **Test Coverage for Jira** — Linked Test Count, Test Coverage

## What the Apps store

In Atlassian-hosted app storage, within your Atlassian site's data residency:

- **Field ids** for each App's own fields, cached to avoid repeated lookups
- **Sprint id → last-seen start and end date** (Sprint Dates only), used to detect
  schedule changes so the App rewrites only sprints that actually moved
- **A progress cursor** for sprints large enough to process across several runs

No work item content, no user identities, and no personal data are stored.

## Data transmission

None. The Apps make no outbound network requests. They qualify for Atlassian's
**Runs on Atlassian** programme, which requires that an app operate entirely within
Atlassian infrastructure with no external data egress.

## Data retention and deletion

All App data lives in Atlassian-hosted storage tied to your installation.
Uninstalling an App removes its storage and its custom fields, subject to
Atlassian's own retention behaviour (Atlassian retains removed app fields for a
period so that reinstalling restores previous values).

## Sub-processors

None. Because the Apps run wholly on Forge, Atlassian is the only processor
involved, under your existing agreement with Atlassian.

## Changes

Material changes will be reflected here with an updated date, and in the Apps'
Marketplace listings.

## Contact

Vector Grove Capital LLC — please
[open an issue](https://github.com/dentwon/vgc-legal/issues).
