#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${company:-}" ]]; then
  echo "Error: company is not set. Export company before running." >&2
  exit 1
fi

base_dir="$(cd "$(dirname "$0")/../.." && pwd)"
templates_dir="${TEMPLATES_DIR:-$HOME/Library/Group Containers/UBF8T346G9.Office/User Content/Templates}"
install_dir="$templates_dir/zzInstallationPackages/${company}_Templates_Install"
signature_dir="$install_dir/Signature"

mkdir -p "$signature_dir"

echo "----------------------"
echo "Generic - BaseTemplate"
echo "----------------------"

copy_file() {
  local src="$1"
  local dest="$2"
  if [[ -f "$src" ]]; then
    cp -f "$src" "$dest/"
  else
    echo "Missing file: $src" >&2
  fi
}

copy_file "$base_dir/Generic/BaseTemplate/BaseTemplate.dotm" "$install_dir"
copy_file "$base_dir/Generic/BaseTemplate/InstallSignature.txt" "$signature_dir"
copy_file "$base_dir/Generic/BaseTemplate/Signature.PNG" "$signature_dir"
copy_file "$base_dir/Generic/BaseTemplate/CopyrightNotice.txt" "$install_dir"
copy_file "$base_dir/Generic/BaseTemplate/LicenceConditions.txt" "$install_dir"
