#!/usr/bin/env bash
set -euo pipefail

company_name="${1:-}"
if [[ -z "$company_name" ]]; then
  echo "Command line argument needed: 'Company name'" >&2
  exit 1
fi

echo "macOS does not support Windows registry updates."
echo "Skipping macro security settings for '$company_name'."
