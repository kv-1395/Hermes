---
name: hermes-backup
description: "Backup vital Hermes data to a Git remote."
triggers:
  - backup
  - hermes backup
  - cron backup
  - git backup
---

# Hermes Backup

Automated backup of critical Hermes files to a Git remote (GitHub, GitLab, etc.).

## What to back up (vital files)

- `memories/` — user memory (MEMORY.md, USER.md)
- `skills/` — all installed skills
- `config.yaml` — Hermes configuration
- `SOUL.md` — personality/persona
- `kanban.db`, `state.db` — databases
- `cron/` — cron job definitions
- `platforms/` — platform configs
- `hooks/` — hook scripts

## What NOT to back up

- `auth.json` — contains tokens (SENSITIVE)
- `.env` — environment secrets
- `logs/` — large, ephemeral
- `cache/`, `audio_cache/`, `image_cache/` — regenerable
- `*.lock` files — transient state
- `models_dev_cache.json` — regenerable

## Workflow

1. **Write the backup script** to `~/.hermes/scripts/hermes_backup.sh`
2. **Test it immediately** — run the script and verify files appear in the repo
3. **Set up cron job** via `cronjob` tool with `action=create`, `schedule='every 12h'`

## Pitfalls

### Path confusion
The hermes directory is at `$HOME/.hermes` but `$HOME` may not be `/root`. Use `$HOME/.hermes` in scripts, not hardcoded paths. On this system, `HOME=/data` so the hermes dir is `/data/.hermes/`.

### Git HTTPS authentication (port 22 blocked)
When SSH is blocked, use HTTPS with the token embedded in the remote URL:
```bash
git remote set-url origin https://<TOKEN>@github.com/<user>/<repo>.git
```
Or set it during clone. The credential-helper approach may also work:
```bash
git -c credential.helper='!f() { echo "username=<user>"; echo "password=<TOKEN>"; }; f' clone <url>
```

### CRITICAL: Never store tokens in memory
**DO NOT** save GitHub PATs, API keys, or any credentials to Hermes memory (`memory` tool). Instead:
- Save a one-line note like: "If hermes-backup cron fails, ask user for new GitHub token"
- Never include the token value or even its prefix/pattern
- The token should live ONLY in the script file

### Do, don't narrate
When the user asks you to do something, execute it immediately. Don't say "I'll do it now" or "let me do this" — just run the commands. Narrating before acting frustrates users.

## Example backup script

See `references/backup-script.sh` for a complete working example.
