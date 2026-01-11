#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${company:-}" ]]; then
  echo "Error: company is not set. Export company before running." >&2
  exit 1
fi

base_dir="$(cd "$(dirname "$0")/../.." && pwd)"
templates_dir="${TEMPLATES_DIR:-$HOME/Library/Group Containers/UBF8T346G9.Office/User Content/Templates}"
install_dir="$templates_dir/zzInstallationPackages/${company}_Templates_Install"

mkdir -p "$install_dir"

echo "------------------"
echo "Generic - PDMS Interface"
echo "-------------------"

src="$base_dir/Generic/PDMS_Interface/PDMS_Interface.xlsm"
if [[ -f "$src" ]]; then
  cp -f "$src" "$install_dir/"
else
  echo "Missing file: $src" >&2
fi
