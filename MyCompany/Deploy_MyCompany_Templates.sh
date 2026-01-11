#!/usr/bin/env bash
set -euo pipefail

company="MyCompany"
export company

base_dir="$(cd "$(dirname "$0")/.." && pwd)"
"$base_dir/Generic/DeployTemplates/Deploy_Templates.sh"
