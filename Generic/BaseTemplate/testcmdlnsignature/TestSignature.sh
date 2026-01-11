#!/usr/bin/env bash
set -euo pipefail

if command -v magick >/dev/null 2>&1; then
  magick Signature.PNG -stroke "#00AA0090" -strokewidth 10 \
    -draw "line 70,116 121,213" \
    -draw "line 121,213 370,7" \
    -draw "line 370,7 140,155" \
    -stroke green -draw "line 140,155 70,116" \
    -stroke black -pointsize 23 -strokewidth 0 \
    -draw "text 62,182 'Hansie Odendaal'" \
    -draw "text 62,212 '2014-01-17, 7:06 AM'" \
    CompositeSignature.PNG
  exit 0
fi

if command -v convert >/dev/null 2>&1; then
  convert Signature.PNG -stroke "#00AA0090" -strokewidth 10 \
    -draw "line 70,116 121,213" \
    -draw "line 121,213 370,7" \
    -draw "line 370,7 140,155" \
    -stroke green -draw "line 140,155 70,116" \
    -stroke black -pointsize 23 -strokewidth 0 \
    -draw "text 62,182 'Hansie Odendaal'" \
    -draw "text 62,212 '2014-01-17, 7:06 AM'" \
    CompositeSignature.PNG
  exit 0
fi

echo "ImageMagick (magick/convert) not found; cannot generate CompositeSignature.PNG" >&2
exit 1
