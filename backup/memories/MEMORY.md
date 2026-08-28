Environment: port 22 blocked — all git operations must use HTTPS. HOME=/data, hermes config at /data/.hermes. GitHub backup repo: kv-1395/Hermes (token stored in ~/.hermes/scripts/hermes_backup.sh).
§
Backup script: exclude state.db and kanban.db from backup — they contain old GitHub tokens and GitHub Push Protection blocks pushes. Also need to git rm previously committed copies from the repo.
§
Do NOT save tokens, secrets, or credentials to memory. Only operational notes without referencing actual values.
§
Cron shell scripts: use no_agent=true + script=filename (relative to ~/.hermes/scripts/). Without no_agent, cron fails with 'no model configured'. Prompt is ignored when no_agent=true.
§
Quick static deploy: npx netlify-cli deploy --dir=. --prod --allow-anonymous. Free, no auth needed. Sites expire in 60min unless claimed. Good for rapid HTML panel hosting.
§
GitHub repo: github.com/kv-1395/Hermes (public). Backup cron job (hermes-backup-12h) runs every 12h, pushes to main branch. Script at ~/.hermes/scripts/hermes_backup.sh.
§
User dropped the VPN panel project ("رفرش"). Don't bring it up unless asked.