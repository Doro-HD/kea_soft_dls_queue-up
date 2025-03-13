echo "___Setting up cluster___"
kind create cluster --name queue-up --config kind.config.yaml || echo "Cluster already exists"

echo "___Setting up backends and api's___"
./+backends-setup.sh
echo "___Setting up frontends___"
./+frontends-setup.sh

echo "___Setting deployments and services___"
cd k8

./+admin-organiser-setup.sh
./+guest-setup.sh