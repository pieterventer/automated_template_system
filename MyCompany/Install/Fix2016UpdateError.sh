#!/usr/bin/env bash
set -euo pipefail

Company="${Company:-MyCompany}"
templates_dir="${TEMPLATES_DIR:-$HOME/Library/Group Containers/UBF8T346G9.Office/User Content/Templates}"
target_folder="$templates_dir/$Company/Layouts"
target_document="$target_folder/Blank${Company}doc.docx"

if [[ -f "$target_document" ]]; then
  open "$target_document"
else
  echo "Target document not found: $target_document" >&2
  exit 1
fi
