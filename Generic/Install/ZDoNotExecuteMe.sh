#!/usr/bin/env bash
set -u

Company="${Company:-${1:-}}"
if [[ -z "$Company" ]]; then
  echo "cannot be run on its own."
  echo "Please run 'Install.sh' instead."
  exit 1
fi

installPath="${installPath:-$(cd "$(dirname "$0")" && pwd)/}"
templates_dir="${TEMPLATES_DIR:-$HOME/Library/Group Containers/UBF8T346G9.Office/User Content/Templates}"

copy_flags="-f"

error_exit() {
  echo "$1" >&2
  exit 1
}

require_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    error_exit "Missing required file: $path"
  fi
}

require_glob() {
  local pattern="$1"
  shopt -s nullglob
  local matches=( $pattern )
  shopt -u nullglob
  if (( ${#matches[@]} == 0 )); then
    error_exit "Missing required files: $pattern"
  fi
}

echo "Installing $Company templates"

echo "Testing installation package"
require_file "$installPath/ChangeWordMacroSecuritySettings.sh"
require_file "$installPath/close_word.vbs"
require_file "$installPath/close_doc.vbs"
require_file "$installPath/Reg-Office-Base.reg"
require_file "$installPath/Reg-Office-$Company.reg"
require_file "$installPath/PDMS_Interface.xlsm"
require_file "$installPath/${Company}_Competency_db.xlsm"
require_file "$installPath/${Company}_ResourcesAndCompetencies_db.xlsm"
require_file "$installPath/${Company}_Template_db.xlsm"
require_file "$installPath/${Company}_BusinessContacts_db.xlsm"
require_file "$installPath/${Company}_Clauses_db.xlsm"
require_file "$installPath/${Company}_UserAbbreviations_db.xlsm"
require_file "$installPath/BaseTemplate.dotm"
require_glob "$installPath/${Company}_*.dotm"
require_file "$installPath/Blank${Company}Doc.docx"
require_glob "$installPath/UserManual*.pdf"
require_file "$installPath/AutomatedTemplateSystemPresentation.pdf"
require_file "$installPath/CopyrightNotice.txt"
require_file "$installPath/Licence.txt"
require_file "$installPath/LicenceConditions.txt"
require_file "$installPath/Signature/InstallSignature.txt"
require_file "$installPath/Signature/Signature.PNG"

if [[ -f "$installPath/ZCheckFonts.sh" ]]; then
  font_status="$(bash "$installPath/ZCheckFonts.sh" rem)"
  if [[ "$font_status" != "NO_ERROR" ]]; then
    error_exit "Font files test failed: $font_status"
  fi
fi

echo "Installation package OK"

echo "Registry entries for Word macro security are skipped on macOS."

company_dir="$templates_dir/$Company"
base_dir="$templates_dir/Base"
layouts_dir="$company_dir/Layouts"

mkdir -p "$company_dir" "$base_dir" "$layouts_dir"

user_abbrev_tmp="$HOME/${Company}_UserAbbreviations_db.xlsm"
if [[ -f "$company_dir/${Company}_UserAbbreviations_db.xlsm" ]]; then
  mv "$company_dir/${Company}_UserAbbreviations_db.xlsm" "$user_abbrev_tmp"
fi

cp $copy_flags "$installPath/PDMS_Interface.xlsm" "$company_dir/"
cp $copy_flags "$installPath/${Company}_Competency_db.xlsm" "$company_dir/"
cp $copy_flags "$installPath/${Company}_ResourcesAndCompetencies_db.xlsm" "$company_dir/"
cp $copy_flags "$installPath/${Company}_Template_db.xlsm" "$company_dir/"
cp $copy_flags "$installPath/${Company}_BusinessContacts_db.xlsm" "$company_dir/"
cp $copy_flags "$installPath/${Company}_Clauses_db.xlsm" "$company_dir/"
if [[ -f "$user_abbrev_tmp" ]]; then
  cp $copy_flags "$user_abbrev_tmp" "$company_dir/"
  rm -f "$user_abbrev_tmp"
  echo "Re-used ${Company}_UserAbbreviations_db.xlsm"
else
  cp $copy_flags "$installPath/${Company}_UserAbbreviations_db.xlsm" "$company_dir/"
fi

cp $copy_flags "$installPath/CopyrightNotice.txt" "$company_dir/"
cp $copy_flags "$installPath/Licence.txt" "$company_dir/"
cp $copy_flags "$installPath/${Company}_"*.dotm "$company_dir/"
cp $copy_flags "$installPath/UserManual"*.pdf "$company_dir/"
cp $copy_flags "$installPath/AutomatedTemplateSystemPresentation.pdf" "$company_dir/"
cp $copy_flags "$installPath/Blank${Company}Doc.docx" "$layouts_dir/"

if [[ -f "$installPath/ZInstallFonts.sh" ]]; then
  bash "$installPath/ZInstallFonts.sh" NOENABLE rem no_pause_
fi

echo "Base template installation"
cp $copy_flags "$installPath/CopyrightNotice.txt" "$base_dir/"
cp $copy_flags "$installPath/LicenceConditions.txt" "$base_dir/"
cp $copy_flags "$installPath/BaseTemplate.dotm" "$base_dir/"
cp $copy_flags "$installPath/UserManual"*.pdf "$base_dir/"
cp $copy_flags "$installPath/AutomatedTemplateSystemPresentation.pdf" "$base_dir/"
mkdir -p "$base_dir/Signature"
cp $copy_flags "$installPath/Signature/Signature.PNG" "$base_dir/Signature/"
cp $copy_flags "$installPath/Signature/InstallSignature.txt" "$base_dir/Signature/"

echo "Set templates workgroup path is skipped on macOS."

echo "Installed files"
ls -1 "$base_dir" >/dev/null
ls -1 "$company_dir" >/dev/null

require_file "$base_dir/BaseTemplate.dotm"
require_file "$base_dir/CopyrightNotice.txt"
require_file "$base_dir/LicenceConditions.txt"
require_file "$base_dir/Signature/InstallSignature.txt"
require_file "$base_dir/Signature/Signature.PNG"
require_file "$company_dir/CopyrightNotice.txt"
require_file "$company_dir/Licence.txt"
require_file "$company_dir/${Company}_Competency_db.xlsm"
require_file "$company_dir/${Company}_Main.dotm"
require_file "$company_dir/${Company}_ResourcesAndCompetencies_db.xlsm"
require_file "$company_dir/${Company}_Template_db.xlsm"
require_file "$company_dir/${Company}_BusinessContacts_db.xlsm"
require_file "$company_dir/${Company}_Clauses_db.xlsm"
require_file "$company_dir/${Company}_UserAbbreviations_db.xlsm"
require_file "$company_dir/PDMS_Interface.xlsm"
require_file "$layouts_dir/Blank${Company}Doc.docx"

echo
echo "Installation successful!"
