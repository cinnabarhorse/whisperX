#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIGURATION="${CONFIGURATION:-debug}"
TRIPLE="$(swift build --package-path "$ROOT" --configuration "$CONFIGURATION" --show-bin-path)"
APP_DIR="$ROOT/.build/TranscriptViewer.app"
ROOT_ID="$(printf '%s' "$ROOT" | shasum -a 1 | awk '{print substr($1, 1, 10)}')"
BUNDLE_IDENTIFIER="${BUNDLE_IDENTIFIER:-com.codex.whisperx.transcriptviewer.$ROOT_ID}"

mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"
cp "$ROOT/Resources/Info.plist" "$APP_DIR/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLE_IDENTIFIER" "$APP_DIR/Contents/Info.plist"
cp "$TRIPLE/TranscriptViewer" "$APP_DIR/Contents/MacOS/TranscriptViewer"
chmod +x "$APP_DIR/Contents/MacOS/TranscriptViewer"
codesign --force --deep --sign - "$APP_DIR" >/dev/null

echo "$APP_DIR"
echo "$BUNDLE_IDENTIFIER"
