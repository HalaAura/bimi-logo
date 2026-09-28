#!/usr/bin/env bash
# Launches an MCP server with API keys loaded from a local file that stays on this machine.
# Keys file: ~/.config/claude-mcp/keys.env (override with CLAUDE_MCP_KEYS_FILE).
keys_file="${CLAUDE_MCP_KEYS_FILE:-$HOME/.config/claude-mcp/keys.env}"
if [ -f "$keys_file" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$keys_file"
  set +a
fi
# Desktop apps (Claude Cowork) start with a minimal PATH; add the usual tool locations.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
exec "$@"
