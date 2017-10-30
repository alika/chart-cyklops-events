#!/usr/bin/env bash

APP_NAME=cyklops-events
APP_ENV=${APP_ENV:-staging}

REGISTRY_HOST=quay.io
REGISTRY_ORG=samsung_cnct
REGISTRY_USERNAME=${REGISTRY_USERNAME:-quay-repo-robot}
REGISTRY_PASSWORD=${REGISTRY_PASSWORD:-quay-repo-robot-token}

CHART_NAME=${APP_NAME}-chart
CHART_REGISTRY_URI=${REGISTRY_HOST}/${REGISTRY_ORG}/${CHART_NAME}
CHART_REGISTRY_CHANNEL=${CHART_REGISTRY_CHANNEL:-alpha}

if [ -z "${KUBECONFIG}" ]; then
  export KUBECONFIG=/root/.kube/config
fi

helm init --client-only
cd ${APP_NAME}
export CHART_VER_REL=$(grep version Chart.yaml | cut -d ' ' -f2)
export HELM_APP_NAME="${APP_NAME}-${APP_ENV}"
export HELM_OPTS="--install --namespace ${HELM_APP_NAME} --set victorops.apiKey=$VICTOROPS_API_KEY"
helm registry login -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD} ${REGISTRY_HOST}
helm registry upgrade ${CHART_REGISTRY_URI}@${CHART_VER_REL} -- ${HELM_APP_NAME} ${HELM_OPTS}
