#!/bin/bash

# Set Azure KeyVault secrets with the Azure CLI.
#
# The secrets are my Azure Container Registry values/secrets, so that
# Azure DevOps Pipelines can read these, and push to ACR the Docker
# container that it builds in the pipeline.
#
# Chris Joakim, Microsoft, 2019/10/22

# My workstation environment includes the following names:
# AZURE_ACR_LOGIN_SERVER
# AZURE_ACR_NAME
# AZURE_ACR_USER_NAME
# AZURE_ACR_USER_PASS
# AZURE_FUNCTIONS_AKV_NAME

# AKV requires dash-separated rather than underscore-separated names.

# az login   <-- run this first

az keyvault secret set \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-NAME \
    --value $AZURE_ACR_NAME

az keyvault secret set \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-LOGIN-SERVER \
    --value $AZURE_ACR_LOGIN_SERVER

az keyvault secret set \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-USER-NAME \
    --value $AZURE_ACR_USER_NAME

az keyvault secret set \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-USER-PASS \
    --value $AZURE_ACR_USER_PASS

az keyvault secret list --vault-name $AZURE_FUNCTIONS_AKV_NAME

az keyvault secret show \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-NAME 

az keyvault secret show \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-LOGIN-SERVER 

az keyvault secret show \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-USER-NAME 

az keyvault secret show \
    --vault-name $AZURE_FUNCTIONS_AKV_NAME \
    --name  AZURE-ACR-USER-PASS 

echo 'done'
