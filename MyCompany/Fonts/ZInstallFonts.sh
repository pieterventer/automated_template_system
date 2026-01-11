#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" != "NOENABLE" ]]; then
  echo "ZInstallFonts.sh running"
fi

installPath="${installPath:-$(cd "$(dirname "$0")" && pwd)}"
quiet="${2:-}"

font_status="$(bash "$installPath/ZCheckFonts.sh" "$quiet")"
if [[ "$font_status" != "NO_ERROR" ]]; then
  echo "All required font files do not exist" >&2
  echo "$font_status" >&2
  exit 1
fi

# shellcheck source=/dev/null
source "$installPath/ZFontInfo.sh"

fonts_dir="$HOME/Library/Fonts"
mkdir -p "$fonts_dir"
for font in "${myFontFile[@]}"; do
  cp -f "$installPath/$font" "$fonts_dir/"
  echo "Copied $font to $fonts_dir"
 done

echo "Fonts installed"
if [[ "${3:-}" != "no_pause_" ]]; then
  read -r -p "Press Enter to continue..." </dev/tty
fi
