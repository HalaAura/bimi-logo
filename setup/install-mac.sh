#!/usr/bin/env bash
# One-time setup of the hala-tools plugins on a Mac, for Claude Code and Claude Cowork.
# Run in Terminal:  bash setup/install-mac.sh
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

echo "Installing ffmpeg, uv, Node.js and Python..."
brew install ffmpeg uv node python@3.12

echo "Installing Whisper (used by the audio-transcription skill)..."
uv tool install --python 3.12 --with pillow openai-whisper || uv tool upgrade openai-whisper
python3 -m pip install --user --break-system-packages -q openai-whisper pillow || true

echo "Pre-fetching the MCP servers..."
uvx markitdown-mcp --help >/dev/null 2>&1 || true
uvx trends-mcp-server --help </dev/null >/dev/null 2>&1 || true
npm cache add animotion-mcp gpt-image-2-mcp >/dev/null 2>&1 || true

keys="$HOME/.config/claude-mcp/keys.env"
mkdir -p "$(dirname "$keys")"
if [ ! -f "$keys" ]; then
  cat > "$keys" <<'KEYS'
# API keys for the hala-media-toolkit MCP servers. This file stays on this Mac.
OPENAI_API_KEY=
TRENDSMCP_API_KEY=
KEYS
fi
chmod 600 "$keys"

if command -v claude >/dev/null 2>&1; then
  echo "Adding the plugins to Claude Code..."
  claude plugin marketplace add halaaura/bimi-logo || claude plugin marketplace update hala-tools
  claude plugin install hala-media-toolkit@hala-tools
  claude plugin install remotion@hala-tools
else
  echo "Claude Code CLI not found; skipping. In Claude Code run:"
  echo "  /plugin marketplace add halaaura/bimi-logo"
fi

cat <<MSG

Done. Remaining steps:
  1. Put your keys in: $keys
       open -e "$keys"
  2. In Claude Cowork: Customize -> Plugins -> add marketplace "halaaura/bimi-logo",
     then install "hala-media-toolkit" and "remotion".
  3. Restart Claude (Code and Cowork).
MSG
