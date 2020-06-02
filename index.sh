#!/bin/bash

set +e

helm repo add hashicorp https://helm.releases.hashicorp.com
echo "$(helm search repo hashicorp -l | tail -n +2)" | while read -r line; do
    RELEASE_WITH_REPO=$(echo $line | awk '{ print $1 }')
    VERSION=$(echo $line | awk '{ print $2 }')
    RELEASE_NAME=${RELEASE_WITH_REPO#hashicorp/}
    mkdir -p $RELEASE_NAME
    helm pull $RELEASE_WITH_REPO --version $VERSION --destination $RELEASE_NAME || true
done

helm repo index --url https://ryansiu1995.github.io/hashicorp-helm/ .
