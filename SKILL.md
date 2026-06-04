---
name: mau-clipping
description: "Viral YouTube Shorts hook + CTA stitching for TikTok + IG + YT. Scrapes top hooks from maboroshi-style source videos, trims to 15-59s, stitches a CTA overlay, uploads to Postiz. POST_PLATFORMS env controls which platforms receive posts."
homepage: https://github.com/Daisuke134/mau-clipping
metadata:
  tags: tiktok, instagram, youtube, shorts, clipping, postiz, automation, mau, viral
  requires:
    bins: [ffmpeg, ffprobe, yt-dlp, node]
    env: [POSTIZ_API_KEY, POSTIZ_YT_INTEGRATION_ID]
---

# mau-clipping

Scrape viral hook clips → trim to 15-59s → stitch CTA → post to TikTok + Instagram + YouTube Shorts automatically.

## Use when

- You want to repurpose viral long-form content into short-form hooks for TikTok, Instagram Reels, and YouTube Shorts.
- You have Postiz integrations for 1-3 platforms and want automated daily posting.
- You want env-level platform control (`POST_PLATFORMS=youtube` for YT-only, `POST_PLATFORMS=tiktok,instagram` for social only).

## Use when NOT

- You want AI-generated talking-head videos (use `anicca-monk-factory` instead).
- You want original script generation (this skill is clip-reuse only).
- You need text-to-speech voice overlay (out of scope).

## Quick run

```bash
# Step 1: scrape hooks from source
node scripts/scrape-hooks.js --lang en --count 5

# Step 2: trim + stitch CTA
node scripts/trim-and-stitch.js --lang en

# Step 3: post to Postiz
POST_PLATFORMS=tiktok,instagram,youtube node scripts/post-to-postiz.js --lang en
```

Full setup: see `QUICKSTART.md`.

## Architecture

```
scrape-hooks.js (yt-dlp)
   └── hooks/{lang}/*.mp4  (raw clips)
trim-and-stitch.js (ffmpeg)
   └── output/{lang}/*.mp4 (hook + CTA stitched)
post-to-postiz.js
   └── POST_PLATFORMS env → TikTok / Instagram / YouTube via Postiz API
```
