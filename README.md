# apps.vectorgrovecapital.com

The Vector Grove developer site: the two Atlassian Marketplace apps, the security
posture, support policy, and the legal documents a Marketplace partner must publish.

Served by **GitHub Pages** (legacy Jekyll build) from `main` at the repository root,
on the custom domain `apps.vectorgrovecapital.com` with HTTPS enforced.

## Layout

```
_config.yml            site config. url + baseurl are load-bearing -- see below
_layouts/default.html  the only layout
_includes/nav.html     masthead, shared by every page
_includes/footer.html  footer, shared by every page
assets/css/site.css    hand-written, no framework, no build step
assets/logo.svg        PLACEHOLDER mark -- swap this one file to change it everywhere
index.md               home
apps/*.md              one page per app
security.md            scopes and stored data, per app
support.md             response targets and what to include in a report
terms.md               website terms of use
privacy-policy.md      legal, names the LLC, URL must not change
eula.md                legal, names the LLC, URL must not change
404.html
```

## Two things that will break the site

**1. `baseurl` must stay `""`.** Without `_config.yml`, Jekyll inherits
`baseurl: /vgc-legal` from the repository metadata, and since the site is served at the
root of a custom domain, *every* internal link and the stylesheet 404s. That is not
hypothetical: it was the live state of this site until 2026-07-26, and every link on
the home page was dead while the pages themselves returned 200. Checking that a URL
returns 200 does not check the links on it.

**2. Do not enable the Cloudflare proxy on the `apps` DNS record.** It must stay
DNS-only (grey cloud), or GitHub cannot issue the Pages TLS certificate.

## Verifying a change

There is no local Ruby, so the build is verified against the live site after pushing:

```powershell
./check-site.ps1            # after the Pages build finishes
```

It asserts every page returns 200, follows every internal link and stylesheet found in
the rendered HTML, and fails on any that does not resolve. Run it after every push.

Build status independently of the content:

```powershell
gh api repos/vector-grove-capital/vgc-legal/pages/builds/latest
```

## Rules for content

- The customer-facing brand is **Vector Grove**. `Vector Grove Capital LLC` appears in
  the EULA, the privacy policy, the website terms and the footer's legal line only.
- Do not claim board columns or dashboard gadgets. Those surfaces are unverified.
- Do not publish prices. The Marketplace listing is the binding place for pricing; a
  price here would drift the moment it changed there.
- `/privacy-policy` and `/eula` are submitted to Atlassian. **Do not add a `permalink`
  to those two files** -- it would move them to `/privacy-policy/` and turn a live
  listing URL into a redirect.
