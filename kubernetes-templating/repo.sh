#!/bin/bash

[[ ! "$(helm plugin list)" =~ "push" ]] && helm plugin install https://github.com/chartmuseum/helm-push.git

helm repo add templating https://harbor.84.201.137.227.nip.io/chartrepo/library
helm push --username admin --password Harbor321 frontend/ templating
helm push --username admin --password Harbor321 hipster-shop/ templating

