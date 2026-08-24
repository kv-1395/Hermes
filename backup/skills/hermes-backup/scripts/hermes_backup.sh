#!/bin/bash
# Hermes Backup Script — backs up vital files to a GitHub repo
set -e

REPO_DIR="/tmp/hermes-backup-repo"
HERMES_DIR="$HOME/.hermes"
BACKUP_DIR="$REPO_DIR/backup"
TOKEN="<YOUR_GITHUB_PAT_HERE>"
REPO_URL="https://github.com/<USER>/<REPO>.git"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

echo "=== Hermes Backup - $TIMESTAMP ==="

# Clone or update repo
if [ ! -d "$REPO_DIR" ]; then
    git clone "https://${TOKEN}@${REPO_URL#https://}" "$REPO_DIR"
fi
cd "$REPO_DIR"
git config user.email "hermes-backup@bot"
git config user.name "Hermes Backup"
git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || true

# Clean old backup
rm -rf "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup vital files
echo "Backing up..."
[ -d "$HERMES_DIR/memories" ] && cp -r "$HERMES_DIR/memories" "$BACKUP_DIR/" && echo "  ✓ memories/"
[ -d "$HERMES_DIR/skills" ] && cp -r "$HERMES_DIR/skills" "$BACKUP_DIR/" && echo "  ✓ skills/"
[ -f "$HERMES_DIR/config.yaml" ] && cp "$HERMES_DIR/config.yaml" "$BACKUP_DIR/" && echo "  ✓ config.yaml"
[ -f "$HERMES_DIR/SOUL.md" ] && cp "$HERMES_DIR/SOUL.md" "$BACKUP_DIR/" && echo "  ✓ SOUL.md"
[ -f "$HERMES_DIR/kanban.db" ] && cp "$HERMES_DIR/kanban.db" "$BACKUP_DIR/" && echo "  ✓ kanban.db"
[ -f "$HERMES_DIR/state.db" ] && cp "$HERMES_DIR/state.db" "$BACKUP_DIR/" && echo "  ✓ state.db"
[ -d "$HERMES_DIR/cron" ] && cp -r "$HERMES_DIR/cron" "$BACKUP_DIR/" && echo "  ✓ cron/"
[ -d "$HERMES_DIR/platforms" ] && cp -r "$HERMES_DIR/platforms" "$BACKUP_DIR/" && echo "  ✓ platforms/"
[ -d "$HERMES_DIR/hooks" ] && cp -r "$HERMES_DIR/hooks" "$BACKUP_DIR/" && echo "  ✓ hooks/"

# Commit and push
cd "$REPO_DIR"
git add -A
if git diff --cached --quiet; then
    echo "No changes to commit."
else
    git commit -m "Backup: $TIMESTAMP"
    git push origin HEAD 2>&1
    echo "=== Backup pushed to GitHub ✓ ==="
fi
