#!/usr/bin/env bash
set -euo pipefail

Company="${Company:-MyCompany}"
installPath="$(cd "$(dirname "$0")" && pwd)"

if [[ -f "$installPath/ZDoNotExecuteMe.sh" ]]; then
  Company="$Company" installPath="$installPath" bash "$installPath/ZDoNotExecuteMe.sh" "$Company"
else
  echo "Not all installation files are present."
  echo "Please unzip and execute from the unzipped folder/directory."
  exit 1
fi
