Environment: port 22 blocked — all git operations must use HTTPS. HOME=/data, hermes config at /data/.hermes. GitHub backup repo: kv-1395/Hermes (token stored in ~/.hermes/scripts/hermes_backup.sh).
§
Hermes backup cron: hermes-backup-12h (job a1f9edf8eab6). Every 12h → github.com/kv-1395/Hermes (private). Script: /data/.hermes/scripts/hermes_backup.sh. If auth fails, ask user for new token.
§
Do NOT save tokens, secrets, or credentials to memory. Only operational notes without referencing actual values.
§
Cron shell scripts: use no_agent=true + script=filename (relative to ~/.hermes/scripts/). Without no_agent, cron fails with 'no model configured'. Prompt is ignored when no_agent=true.
§
Quick static deploy: npx netlify-cli deploy --dir=. --prod --allow-anonymous. Free, no auth needed. Sites expire in 60min unless claimed. Good for rapid HTML panel hosting.