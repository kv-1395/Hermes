# Cron Job Setup for Backup Scripts

## Key Requirements

When setting up a cron job for a shell script backup:

1. **Always use `no_agent=True`** — shell scripts don't need an LLM
2. **Script path must be relative** — just the filename, e.g. `hermes_backup.sh`
3. **Set `prompt=''`** (empty) when using no_agent

## Example

```
cronjob(
  action='create',
  schedule='every 12h',
  no_agent=True,
  script='hermes_backup.sh',
  name='hermes-backup-12h',
  deliver='origin'
)
```

## Common Errors

### RuntimeError: no model configured
- Cause: `no_agent` was not set, so the system tried to spawn an LLM agent
- Fix: Set `no_agent=True`

### Script path error
- Cause: Used absolute path like `/data/.hermes/scripts/hermes_backup.sh`
- Fix: Use just the filename `hermes_backup.sh`
