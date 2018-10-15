#!/bin/bash
echo Started K8s-deploy

if [ ${WERCKER_K8S_DEPLOY_TYPE} = "rolling-update" ]
then
  echo Attempting Rolling update for ${WERCKER_K8S_DEPLOY_DEPLOYMENT}
  ${WERCKER_OUTPUT_DIR}/kubectl --server=${WERCKER_K8S_DEPLOY_SERVER} --token=${WERCKER_K8S_DEPLOY_TOKEN} --insecure-skip-tls-verify set image deployment.apps/${WERCKER_K8S_DEPLOY_DEPLOYMENT} ${WERCKER_K8S_DEPLOY_OLD_IMAGE}=${WERCKER_K8S_DEPLOY_NEW_IMAGE}
  ${WERCKER_OUTPUT_DIR}/kubectl rolliout status ${WERCKER_K8S_DEPLOY_DEPLOYMENT}
elif [ ${WERCKER_K8S_DEPLOY_TYPE} = "blue-green" ]
then
  echo Attempting blue-green update for ${WERCKER_K8S_DEPLOY_DEPLOYMENT}
elif [ ${WERCKER_K8S_DEPLOY_TYPE} = "canary" ]
then
  echo Attempting canary update for ${WERCKER_K8S_DEPLOY_DEPLOYMENT}
fi