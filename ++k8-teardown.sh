#!/bin/bash

# Set the namespace to use
NAMESPACE="default"

# Function to tear down resources in the cluster
gum format "# Tearing down the cluster..."

# Delete the deployment
kubectl delete --all deployments -n $NAMESPACE
kubectl delete --all services -n $NAMESPACE

# Verify that resources are deleted
kubectl get all -n $NAMESPACE

gum format "# Resources removed!"

# Optionally, delete the entire cluster (if you want)
kind delete cluster --name queue-up
