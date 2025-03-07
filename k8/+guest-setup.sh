NAMESPACE="default"

# Apply the deployment and service (replace this with your own yaml file)
kubectl apply -f guest_deployment.yaml -n $NAMESPACE
kubectl apply -f guest_service.yaml -n $NAMESPACE