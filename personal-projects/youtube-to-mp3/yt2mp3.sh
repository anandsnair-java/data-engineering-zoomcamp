#!/usr/bin/env bash
#
# yt2mp3.sh — download a video's audio and encode it to high-quality MP3.
#
# Usage:
#   ./yt2mp3.sh <URL> [output_dir]
#
# Requirements: yt-dlp and ffmpeg (see README.md for install steps).
#
# NOTE: Only download content you own or are licensed to use.

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <URL> [output_dir]" >&2
  exit 1
fi

URL="$1"
OUT_DIR="${2:-./downloads}"

# High-quality MP3 settings:
#   --audio-quality 0  -> best (320 kbps for CBR, or top VBR via LAME)
#   -b:a 320k          -> force 320 kbps CBR for consistency
mkdir -p "$OUT_DIR"

yt-dlp \
  --extract-audio \
  --audio-format mp3 \
  --audio-quality 0 \
  --postprocessor-args "ffmpeg:-codec:a libmp3lame -b:a 320k" \
  --embed-thumbnail \
  --add-metadata \
  --output "${OUT_DIR}/%(title)s.%(ext)s" \
  "$URL"

echo "Done. Files saved to: ${OUT_DIR}"
