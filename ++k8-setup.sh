echo "___Creating k8 Cluster___"
kind create cluster --name queue-up --config kind.config.yaml || echo "Cluster already exists"

echo "___Building backend/api's images___"
./+backends-setup.sh
echo "___Building frontend images___"
./+frontends-setup.sh

echo "___Applying k8 deployments and services___"
kubectl apply -f k8