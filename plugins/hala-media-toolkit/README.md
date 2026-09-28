# hala-media-toolkit

| Component | Type | Source | Needs |
|---|---|---|---|
| markitdown | MCP | microsoft/markitdown (`markitdown-mcp`) | uv |
| animotion | MCP | `animotion-mcp` (npm) | Node |
| gpt-image-2 | MCP | Borys520/gpt-image-2-mcp (npm) | Node, `OPENAI_API_KEY` |
| trends | MCP | trendsmcp-ai/Trends-MCP (`trends-mcp-server`) | uv, `TRENDSMCP_API_KEY` |
| motion-graphics | skill | aryankumar06/claude-code-skills | Python, Pillow, ffmpeg |
| audio-transcription | skill | aryankumar06/claude-code-skills + openai/whisper | Whisper, ffmpeg |
| test-case-generator | skill | aryankumar06/claude-code-skills | — |

Remotion (remotion-dev/claude-code-plugin) is listed in the same marketplace as its own plugin.

Keys are read from `~/.config/claude-mcp/keys.env` (or the environment), never from this repo.
Mac setup: `bash setup/install-mac.sh`.
