---
name: static-site-deployment
description: "Deploy static HTML to GitHub Pages or Netlify."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux]
metadata:
  hermes:
    tags: [deployment, GitHub Pages, Netlify, static-site, HTML, hosting]
    related_skills: [github-repo-management]
---

# Static Site Deployment

Deploy single-file or multi-file static HTML sites. Two primary paths: GitHub Pages (persistent) and Netlify (quick/expiring).

## Prerequisites

- Git with HTTPS credentials configured (port 22 often blocked)
- GitHub PAT with `repo` scope
- `npx netlify-cli` installed globally (for Netlify path)

---

## Path 1: GitHub Pages (Recommended for persistent hosting)

Best for: dashboards, VPN panels, portfolio sites — anything that should stay live.

### Setup (one-time)

```bash
# Create gh-pages branch if it doesn't exist
cd /path/to/repo
git checkout -b gh-pages 2>/dev/null || git checkout gh-pages

# Push to GitHub
git push -u origin gh-pages

# Enable GitHub Pages via API (source: gh-pages branch, root /)
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/OWNER/REPO/pages \
  -d '{"build_type":"legacy","source":{"branch":"gh-pages","path":"/"}}'
```

### Deploy (each update)

```bash
cd /path/to/repo
git checkout gh-pages
cp /path/to/index.html ./index.html
git add index.html
git commit -m "Deploy: <description>"
git push origin gh-pages
```

### URL Pattern

```
https://OWNER.github.io/REPO/
```

### Pitfalls

- **Port 22 blocked?** Use HTTPS-only git. Set credential helper: `git config --global credential.helper store`
- **GitHub Pages requires repo to be PUBLIC** (or Pages enabled in repo settings for private repos on paid plans).
- **GitHub Pages may take 1-2 minutes** to reflect changes after push.
- **Branch must be `gh-pages`** (or configure a different source branch via API).
- **If Pages returns 404:** check repo Settings → Pages → ensure source branch is set correctly.

---

## Path 2: Netlify Anonymous Deploys (Quick/expiring)

Best for: rapid testing, throwaway demos, one-off shares.

### Deploy

```bash
cd /path/to/site-dir
npx netlify-cli deploy --dir=. --prod --allow-anonymous
```

### URL Pattern

```
https://<random-name>.netlify.app/
```

### Pitfalls

- **Anonymous deploys expire in 60 minutes** unless claimed with a Netlify account.
- **Daily anonymous deploy limit exists.** If you get an error about limits, use GitHub Pages instead.
- **No persistence** — data stored in localStorage on the client. Page reloads may lose state.
- **Single-file only** — for single HTML files this is ideal.

---

## Path Comparison

| Feature | GitHub Pages | Netlify Anonymous |
|---------|-------------|-------------------|
| Persistence | ✅ Permanent | ❌ 60min expiry |
| Cost | Free | Free (limited) |
| Daily limit | No | Yes (exhaustible) |
| Custom domain | Yes (HTTPS) | Yes (if claimed) |
| Setup time | ~5 min first time | Instant |
| Best for | Production panels | Quick demos |

---

## Common Workflow: Single HTML Panel

1. Write the complete HTML file to a working directory
2. Choose deployment path: permanent → GitHub Pages, temporary → Netlify
3. After deploy, advise user to **hard-refresh** (Ctrl+Shift+R) if changes don't appear

### Browser Cache Pitfall

Users may report "it's not working" or "can't log in" after a deploy. The #1 cause is **stale browser cache**. Always advise:
- Hard refresh: `Ctrl + Shift + R` (Windows/Linux) or `Cmd + Shift + R` (Mac)
- Or clear site data in browser DevTools → Application → Storage
