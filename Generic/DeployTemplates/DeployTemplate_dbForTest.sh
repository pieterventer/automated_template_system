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

echo "-----------------"
echo "$company - Template_db"
echo "-----------------"

copy_file() {
  local src="$1"
  if [[ -f "$src" ]]; then
    cp -f "$src" "$install_dir/"
  else
    echo "Missing file: $src" >&2
  fi
}

copy_file "$base_dir/$company/${company}_Template_db/${company}_Template_db.xlsm"
copy_file "$base_dir/$company/${company}_Template_db/${company}_UserAbbreviations_db.xlsm"
copy_file "$base_dir/$company/${company}_Template_db/${company}_BusinessContacts_db.xlsm"
copy_file "$base_dir/$company/${company}_Template_db/${company}_Clauses_db.xlsm"
