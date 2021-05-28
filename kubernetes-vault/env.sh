#!/bin/sh

export VAULT_SA_NAME=$(kubectl get sa vault-auth -o jsonpath="{.secrets[*]['name']}" -n hashicorp-vault)
export SA_JWT_TOKEN=$(kubectl get secret $VAULT_SA_NAME -o jsonpath="{.data.token}" -n hashicorp-vault | base64 --decode; echo)
export SA_CA_CRT=`$(kubectl get secret $VAULT_SA_NAME -o jsonpath="{.data['ca.crt']}" -n hashicorp-vault | base64 --decode; echo)`
export K8S_HOST="$(more ~/.kube/config | grep server |awk '/http/ {print $NF}')"
### alternative way
# export K8S_HOST="$(kubectl cluster-info | grep ‘Kubernetes master’ | awk ‘/https/ {print $NF}’ | sed ’s/\x1b\[[0-9;]*m//g’ )"
