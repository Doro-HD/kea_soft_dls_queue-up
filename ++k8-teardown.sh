#!/bin/bash

# Set the namespace to use
NAMESPACE="default"

# Function to tear down resources in the cluster
gum log -l info "Removing resource"

# Delete the deployment
kubectl delete --all deployments --all-namespaces
kubectl delete --all services --all-namespaces

# Verify that resources are deleted
kubectl get all -n $NAMESPACE

gum log -l info "Deleting cluster!"

# Optionally, delete the entire cluster (if you want)
kind delete cluster --name queue-up
