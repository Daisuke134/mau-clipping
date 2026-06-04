#!/usr/bin/env bash
# install.sh — register skill into ~/.claude/skills/ + prereq doctor
set -euo pipefail

SKILL_NAME="mau-clipping"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude/skills/$SKILL_NAME"

if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
  echo "removing existing $TARGET"
  rm -rf "$TARGET"
fi
mkdir -p "$HOME/.claude/skills"
ln -s "$REPO_DIR" "$TARGET"
echo "✓ symlinked $TARGET → $REPO_DIR"

echo
echo "=== prereq doctor ==="
miss=0
for bin in ffmpeg ffprobe yt-dlp node; do
  if command -v "$bin" >/dev/null 2>&1; then echo "✓ $bin"; else echo "✗ $bin not found"; miss=1; fi
done
[ -f "$REPO_DIR/.env" ] && echo "✓ .env present" || { echo "✗ .env missing — cp .env.example .env"; miss=1; }

echo
[ "$miss" = "0" ] && echo "🟢 ready to run: node scripts/scrape-hooks.js --lang en --count 5" || echo "🟡 install missing prereqs first"
exit "$miss"
