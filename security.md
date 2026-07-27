---
layout: default
permalink: /security/
title: Security and data
heading: Security and data
standfirst: What each app can reach, what it stores, and why "no data leaves Atlassian" is a property of the platform rather than a promise.
description: Vector Grove's Jira apps run on Atlassian Forge with no egress permissions. This page lists the exact scopes each app requests and the exact data each one stores.
---

## The platform does the enforcing

Both apps are **Atlassian Forge** apps. Forge apps run on Atlassian's own
infrastructure, and an app can only reach the outside world if its manifest declares an
external permission &mdash; which Atlassian shows you at install time.

**Neither app declares any external permission.** There is no allowlisted domain, no
outbound fetch, and no place for data to go. This is not a policy commitment that could
quietly change; it is visible in the app manifest and enforced by the platform.

Consequences worth stating:

- There are no Vector Grove servers. We do not operate a backend, so there is nothing
  of yours for us to lose, subpoena or leak.
- You never hand over an API token or an OAuth credential to us.
- **We cannot see your data.** Support requests therefore need you to tell us what you
  are seeing &mdash; we cannot look.

## Exactly what each app can read

Forge scopes, as declared in each manifest and as Atlassian shows them at install time.

### Sprint Dates for Jira

| Scope | What it permits |
|---|---|
| `read:board-scope:jira-software` | List boards |
| `read:sprint:jira-software` | Read sprints: name, id, state, start and end dates |
| `read:project:jira` | Read project metadata |
| `read:issue-details:jira` | Read work item details |
| `read:jql:jira` | Run JQL searches to find the items needing an update |
| `read:jira-work` / `write:jira-work` | Read work items and write the app's own fields |
| `storage:app` | Atlassian-hosted storage for the app |

### Test Coverage for Jira

| Scope | What it permits |
|---|---|
| `read:issue-details:jira` | Read work item type and links |
| `read:jql:jira` | Run JQL searches to find the items needing an update |
| `read:jira-work` / `write:jira-work` | Read work items and write the app's own fields |
| `storage:app` | Atlassian-hosted storage for the app |

## What each app writes

Only the custom fields it defines. Forge permits an app to write solely its own fields,
so neither app is capable of modifying any other field in your instance &mdash; not
Jira's, and not another vendor's.

- **Sprint Dates for Jira** &mdash; Sprint Start Date, Sprint End Date
- **Test Coverage for Jira** &mdash; Linked Test Count, Test Coverage

## What each app stores

In Atlassian-hosted app storage, inside your Atlassian cloud tenancy. Not on any Vector
Grove system, because there is not one.

| App | Stored | Why |
|---|---|---|
| Sprint Dates | Sprint id, with that sprint's start and end date | To notice when a sprint's schedule changes, since Jira raises no event for it |
| Sprint Dates | A pagination cursor while a large sprint is being processed | So a partially finished sweep resumes rather than restarting |
| Sprint Dates | The internal ids of its own two custom fields | A cache, so field lookup is not repeated on every invocation |
| Test Coverage | The internal ids of its own two custom fields | The same cache; this app stores nothing else at all |

No work item summaries, descriptions, comments, attachments or user personal data are
stored by either app. Neither app stores anything that identifies a person.

## What neither app reads

Work item summaries, descriptions, comments, attachments, and custom field values
belonging to other apps. Neither app touches Confluence, Bitbucket, or any other
Atlassian product.

Test Coverage reads the *type name* of linked work items and the links themselves. It
does not read the content of a linked test.

## Uninstalling

Removing an app removes its fields and the values in them. The app's storage is inside
your Atlassian tenancy and goes with it. Nothing is retained anywhere else, because
there is nowhere else.

## Reporting a security issue

Email is not published to avoid scraping; open a private report through the
[issue tracker]({{ site.github_issues }}) or, for anything you consider sensitive,
raise a low-detail issue asking for a private channel and one will be provided the same
business day.

Formal terms are in the [privacy policy]({{ '/privacy-policy' | relative_url }}) and the
[end user licence agreement]({{ '/eula' | relative_url }}).
