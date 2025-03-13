NAMESPACE="default"

# Apply the deployment and service (replace this with your own yaml file)
kubectl delete deployment qu-admin-organiser-deployment -n $NAMESPACE
kubectl delete service qu-admin-organiser-service -n $NAMESPACE