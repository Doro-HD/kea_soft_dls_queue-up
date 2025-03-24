# Apply the deployment and service (replace this with your own yaml file)
kubectl apply -f authenticator.yaml 
kubectl apply -f message_broker.yaml
kubectl apply -R -f admin_organiser 