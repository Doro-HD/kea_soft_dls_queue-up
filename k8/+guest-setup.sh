NAMESPACE="default"

# Apply the deployment and service (replace this with your own yaml file)
kubectl apply -f authenticator.yaml -n $NAMESPACE
kubectl apply -f rabbitmq_service.yaml -n $NAMESPACE
kubectl apply -R -f guest -n $NAMESPACE