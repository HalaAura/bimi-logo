#!/usr/bin/env bash
# Installs the system tools hala-media-toolkit needs in Claude Code on the web.
# Only runs in cloud sessions; on the Mac, setup/install-mac.sh does this once.
set -uo pipefail
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0

if ! command -v ffmpeg >/dev/null 2>&1; then
  (apt-get update -qq && apt-get install -y -qq ffmpeg) >/dev/null 2>&1 || echo "ffmpeg install failed" >&2
fi
if ! command -v uvx >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1 || echo "uv install failed" >&2
fi
if ! python3 -c "import whisper, PIL" >/dev/null 2>&1; then
  pip install -q torch --index-url https://download.pytorch.org/whl/cpu >/dev/null 2>&1
  pip install -q openai-whisper pillow >/dev/null 2>&1 || echo "whisper install failed" >&2
fi
exit 0
