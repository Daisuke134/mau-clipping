# Quickstart (5 minutes)

## 1. Prereqs

```bash
brew install ffmpeg yt-dlp
node --version   # need >= 18
```

## 2. Clone + install the skill

```bash
git clone https://github.com/Daisuke134/mau-clipping
cd mau-clipping
bash install.sh   # symlinks ~/.claude/skills/mau-clipping/ + runs prereq doctor
```

## 3. Set credentials

```bash
cp .env.example .env
$EDITOR .env   # fill POSTIZ_API_KEY + integration IDs + POST_PLATFORMS
```

## 4. First run — scrape

```bash
node scripts/scrape-hooks.js --lang en --count 5
# Expected: hooks/en/*.mp4 downloaded (5 clips)
```

## 5. Trim + stitch

```bash
node scripts/trim-and-stitch.js --lang en
# Expected: output/en/*.mp4 ready (hook + CTA)
```

## 6. Post

```bash
# Post to all platforms (default)
node scripts/post-to-postiz.js --lang en

# Post to YouTube only
POST_PLATFORMS=youtube node scripts/post-to-postiz.js --lang en

# Post to TikTok + Instagram only
POST_PLATFORMS=tiktok,instagram node scripts/post-to-postiz.js --lang en
```

Expected:
- `[POST] YouTube OK — post id: ...`
- `=== Done: 1/1 platforms posted ===`

## Troubleshooting

| Symptom | Fix |
|---|---|
| `[ERR] No videos found in output/en/` | Run trim-and-stitch first |
| `[ERR] POSTIZ_API_KEY not found` | Fill .env |
| `[ERR] No platforms posted` | Check POST_PLATFORMS + Postiz integration IDs |
| yt-dlp download fails | `yt-dlp --update` — source format may have changed |
