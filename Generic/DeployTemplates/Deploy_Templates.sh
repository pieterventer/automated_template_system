#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${company:-}" ]]; then
  echo "Error: company is not set. Export company before running." >&2
  exit 1
fi

base_dir="$(cd "$(dirname "$0")/../.." && pwd)"
templates_dir="${TEMPLATES_DIR:-$HOME/Library/Group Containers/UBF8T346G9.Office/User Content/Templates}"
install_packages_dir="$templates_dir/zzInstallationPackages"

echo
echo "========================================================================="
echo
echo "Company = $company"
echo

mkdir -p "$templates_dir"
mkdir -p "$install_packages_dir"

run_script() {
  local script_path="$1"
  if [[ -f "$script_path" ]]; then
    bash "$script_path"
  else
    echo "Missing script: $script_path" >&2
  fi
}

run_script "$base_dir/Generic/BaseTemplate/DeployLocalForTest.sh"
echo
run_script "$base_dir/Generic/VBASecurity/DeployLocalForTest.sh"
echo
run_script "$base_dir/Generic/PDMS_Interface/DeployLocalForTest.sh"
echo
run_script "$base_dir/Generic/Install/DeployLocalForTest.sh"
echo
run_script "$base_dir/Generic/UserManual/DeployLocalForTest.sh"
echo
run_script "$base_dir/Generic/DeployTemplates/DeployInstallForTest.sh"
echo
run_script "$base_dir/Generic/DeployTemplates/DeployCompetency_dbForTest.sh"
echo
run_script "$base_dir/Generic/DeployTemplates/DeployTemplate_dbForTest.sh"
echo
run_script "$base_dir/Generic/DeployTemplates/DeployFontsForTest.sh"
echo

if [[ -f "$base_dir/$company/${company}_Main/${company}_Main.dotm" ]]; then
  run_script "$base_dir/Generic/DeployTemplates/DeployMainForTest.sh"
fi
echo

if [[ -f "$base_dir/$company/${company}_Letter/${company}_Letter.dotm" ]]; then
  run_script "$base_dir/Generic/DeployTemplates/DeployLetterForTest.sh"
fi
echo

if [[ -f "$base_dir/$company/${company}_Form/${company}_Form.dotm" ]]; then
  run_script "$base_dir/Generic/DeployTemplates/DeployFormForTest.sh"
fi
echo

echo "========================================================================="
echo
