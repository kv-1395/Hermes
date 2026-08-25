Environment: port 22 blocked — all git operations must use HTTPS. HOME=/data, hermes config at /data/.hermes. GitHub backup repo: kv-1395/Hermes (token stored in ~/.hermes/scripts/hermes_backup.sh).
§
Hermes backup cron: hermes-backup-12h (job a1f9edf8eab6). Every 12h → github.com/kv-1395/Hermes (private). Script: /data/.hermes/scripts/hermes_backup.sh. If auth fails, ask user for new token.
§
Do NOT save tokens, secrets, or credentials to memory. Only operational notes without referencing actual values.
§
Cron shell scripts: use no_agent=true + script=filename (relative to ~/.hermes/scripts/). Without no_agent, cron fails with 'no model configured'. Prompt is ignored when no_agent=true.
§
Quick static deploy: npx netlify-cli deploy --dir=. --prod --allow-anonymous. Free, no auth needed. Sites expire in 60min unless claimed. Good for rapid HTML panel hosting.
§
GitHub repo: github.com/kv-1395/Hermes (public). Backup cron job (hermes-backup-12h) runs every 12h, pushes to main branch. Script at ~/.hermes/scripts/hermes_backup.sh.
§
Building VPN config panel called "رفرش" (Refresh) for user. Deployed on Netlify (anonymous). Features: create/delete/copy/toggle VPN configs (VLESS/VMess/Trojan/Shadowsocks), manage users & servers, ping, logs. User wants text buttons not just icons (Font Awesome doesn't always load).