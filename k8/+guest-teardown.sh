NAMESPACE="default"

# Apply the deployment and service (replace this with your own yaml file)
kubectl delete deployment ff-admin-organiser-deployment -n $NAMESPACE
kubectl delete service ff-admin-organiser-service -n $NAMESPACE