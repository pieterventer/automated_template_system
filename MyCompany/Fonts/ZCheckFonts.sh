#!/usr/bin/env bash
set -euo pipefail

installPath="${installPath:-$(cd "$(dirname "$0")" && pwd)}"
quiet="${1:-}"

# shellcheck source=/dev/null
source "$installPath/ZFontInfo.sh"

missing=()
for font in "${myFontFile[@]}"; do
  if [[ ! -f "$installPath/$font" ]]; then
    missing+=("$font")
    if [[ "$quiet" != "rem" ]]; then
      echo "Could not find $font" >&2
    fi
  elif [[ "$quiet" != "rem" ]]; then
    echo "Found $font"
  fi
 done

for reg in "${myRegFile[@]}"; do
  if [[ ! -f "$installPath/$reg" ]]; then
    missing+=("$reg")
    if [[ "$quiet" != "rem" ]]; then
      echo "Could not find $reg" >&2
    fi
  elif [[ "$quiet" != "rem" ]]; then
    echo "Found $reg"
  fi
 done

if (( ${#missing[@]} )); then
  result="ERROR file not found; ${missing[*]}"
else
  result="NO_ERROR"
fi

echo "$result"
