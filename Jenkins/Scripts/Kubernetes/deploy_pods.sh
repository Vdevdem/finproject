#!/bin/sh

# ----- PETCLINIC -----

# Runs our back end REST API. We must start this before the front end.
envsubst < Kubernetes/deployment.yaml | kubectl apply -f -

# Runs our front end Angular file.
kubectl apply -f Kubernetes/deployment-client.yaml

