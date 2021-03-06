#!/bin/bash
set -o errexit	# Stop script on first error (non-zero returncode)
set -o pipefail	# Stop script on first error in a piped command (default only checks last pipe-command)
#set -o verbose	# Verbose debugprinting of executing scripts
#set -o xtrace	# Show commands being executed through debugprint during execution

# Change directory to src folder based on location relative to the currently executing script #
ScriptLocation="$(realpath "${BASH_SOURCE[0]}")"
ScriptDirectory="$(dirname "${ScriptLocation}")"
cd $ScriptDirectory && cd ..

# Create git repository with initial commit #
git init
git checkout -b main
git add .
git commit -a -m 'Initial commit'

# Create github repository and push #
gh repo create avalier/avalier-test4 --public --source=. --remote=origin
git push -u origin main

