# Demo videos

Keep the demo videos in this `_data/internet/video/` directory. Each player uses a WebM version
first and retains the original MP4 as a fallback:

1. `build-and-run.webm` and `build-and-run.mp4`
2. `3000-2.webm` and `3000-2.mp4`

Preview the site through Jekyll from the project root and open /internet-emulator/#videos.

The WebM versions use VP9 video (plus Opus audio where the original has audio).
The original MP4 recordings are retained at their original resolution. The shared
player lives in `_includes/shared/video.html`; it loads video only on demand.

The network demo poster is extracted from the original footage. The build demo
uses an English SVG cover. When replacing footage, update both source formats
and the relevant poster.

Edit `_data/internet/videos.yml` for video titles and paths. Add each new video
file to `include` in `_config.yml` so Jekyll publishes it.
