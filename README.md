# mau-clipping

> Viral YouTube Shorts hook + CTA stitching for TikTok + IG + YT, end-to-end automated.
> Inspired by [@maboroshi_app](https://www.tiktok.com/@maboroshi.app) — "clone proven viral content" philosophy.

## What it does

Every cron run, this skill:

1. Scrapes top-performing hook clips from source videos (via yt-dlp).
2. Trims each clip to 15-59s Shorts-safe length (ffmpeg).
3. Stitches a CTA overlay onto the clip end.
4. Posts to TikTok + Instagram + YouTube Shorts via Postiz API.
5. Reports results to Slack #metrics.

Set `POST_PLATFORMS` env to control which platforms receive posts (default: all 3).

## Cost

| Service | Monthly cost |
|---|---|
| Postiz (self-host) | $0 |
| yt-dlp | $0 |
| ffmpeg | $0 |
| Total | **$0-15/mo** (hosting only) |

## Quickstart

See `QUICKSTART.md` (5 minutes).

## Prereqs

- macOS (tested) or Linux with brew + node 18+
- `brew install ffmpeg yt-dlp`
- `node --version` >= 18
- Postiz account + platform integrations (TikTok / Instagram / YouTube)

## Architecture

```
cron (0 9,20 * * * JST)
   │
   ▼
scrape-hooks.js
   ├── yt-dlp source playlist/channel
   ├── filter by duration + views
   └── download top N clips → hooks/{lang}/

trim-and-stitch.js
   ├── trim to 15-59s (hook segment)
   ├── stitch CTA overlay (ffmpeg)
   └── write output/{lang}/*.mp4

post-to-postiz.js
   ├── upload video to Postiz media
   ├── POST_PLATFORMS env parse (default: tiktok,instagram,youtube)
   ├── post to each configured integration
   └── append to post-log.json
```

## Platform policy (POST_PLATFORMS)

| Value | Behavior |
|---|---|
| `tiktok,instagram,youtube` | All 3 platforms (OSS default) |
| `youtube` | YouTube Shorts only (Anicca runtime default) |
| `tiktok,instagram` | Social only, skip YT |

## Inspiration + credits

- @maboroshi_app — the "clone proven viral content" philosophy
- Daisuke134/mau-tiktok — original Anicca runtime skill (YT-only variant)

## License

MIT
