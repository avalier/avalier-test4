#!/bin/bash

DEVOPS_NAME=avalier
PROJECT=$1

if [ -z $PROJECT ]
then
    echo "Usage: $0 <<Project>>"
    exit 0
fi

echo "DEVOPS_NAME: $DEVOPS_NAME"
echo "Project: $PROJECT"

# Change directory to git root folder based on location relative to the currently executing script #
ScriptLocation="$(realpath "${BASH_SOURCE[0]}")"
ScriptDirectory="$(dirname "${ScriptLocation}")"
cd $ScriptDirectory && cd .. && cd ..

# Setup pipeline for CI #
az pipelines create --name 'Avalier.Test4 (CI)' --description 'Avalier.Test4 - Continous Integration' --project $PROJECT --repository Avalier.Test4 --repository-type tfsgit --branch master --yml-path .ado/azure-pipelines.yml #--skip-first-run
az pipelines create --name 'Avalier.Test4 (CD - AKS)' --description 'Avalier.Test4 - Continuous Delivery (AKS)' --project $PROJECT --repository Avalier.Test4 --repository-type tfsgit --branch master --yml-path .ado/azure-pipelines-cd-aks.yml --skip-first-run
az pipelines create --name 'Avalier.Test4 (CD - Demo)' --description 'Avalier.Test4 - Continuous Delivery (Demo)' --project $PROJECT --repository Avalier.Test4 --repository-type tfsgit --branch master --yml-path .ado/azure-pipelines-cd-demo.yml --skip-first-run
az pipelines create --name 'Avalier.Test4 (Bump)' --description 'Avalier.Test44 - Bump Version (using npx standard-version)' --project $PROJECT --repository Avalier.Test4 --repository-type tfsgit --branch master --yml-path .ado/azure-pipelines-create-release.yml --skip-first-run

#git tag 0.1
#git push --tags