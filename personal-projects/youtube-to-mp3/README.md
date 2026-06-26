# YouTube → MP3 (high quality)

Download a video's audio and encode it to **high-quality MP3 (320 kbps)** using
[`yt-dlp`](https://github.com/yt-dlp/yt-dlp) + [`ffmpeg`](https://ffmpeg.org/).

> ⚠️ Only download content you own or are licensed to use. Downloading
> copyrighted material may violate the source site's Terms of Service.

## Install dependencies

**macOS (Homebrew):**
```bash
brew install yt-dlp ffmpeg
```

**Debian/Ubuntu:**
```bash
sudo apt update && sudo apt install -y ffmpeg
python3 -m pip install --upgrade yt-dlp
```

**Windows:** install ffmpeg from https://www.gyan.dev/ffmpeg/builds/ and add it
to PATH, then `pip install yt-dlp`.

## Usage

```bash
./yt2mp3.sh <URL> [output_dir]
```

Example:
```bash
./yt2mp3.sh "https://youtu.be/VIDEO_ID" ./downloads
```

Output MP3 files land in `./downloads/` by default.

## Quality settings

The script forces **320 kbps CBR** via `libmp3lame`:

```
--audio-quality 0
--postprocessor-args "ffmpeg:-codec:a libmp3lame -b:a 320k"
```

To use high-quality **VBR** instead (~245 kbps avg, smaller files), swap the
postprocessor args for: `ffmpeg:-codec:a libmp3lame -q:a 0`.

## Plain ffmpeg (if you already have the audio/video file)

```bash
ffmpeg -i input.mp4 -vn -c:a libmp3lame -b:a 320k output.mp3
```
