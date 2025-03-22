#!/bin/bash

function create_cluster() {
    gum format "# Creating k8 Cluster"
    kind create cluster --name queue-up --config kind.config.yaml || echo "Cluster already exists"
}

function build_admin_organiser() {
    gum format "# Building admin organiser"

    docker buildx build -f ./apps/admin_organiser/Dockerfile --target qu_admin_organiser_backend -t qu-admin-organiser-backend:latest .
    docker buildx build -f ./apps/admin_organiser/Dockerfile --target qu_admin_organiser_frontend -t qu-admin-organiser-frontend:latest .
    docker buildx build -f ./apps/admin_organiser/Dockerfile --target qu_admin_organiser_synchronizer_api -t qu-admin-organiser-synchronizer-api:latest .

    kind load docker-image qu-admin-organiser-backend:latest --name queue-up
    kind load docker-image qu-admin-organiser-frontend:latest --name queue-up
    kind load docker-image qu-admin-organiser-synchronizer-api:latest --name queue-up
}

function build_guest() {
    gum format "# Building guest"

    docker buildx build -f ./apps/guest/Dockerfile --target qu_guest_backend -t qu-guest-backend:latest .
    docker buildx build -f ./apps/guest/Dockerfile --target qu_guest_frontend -t qu-guest-frontend:latest .
    docker buildx build -f ./apps/guest/Dockerfile --target qu_guest_synchronizer_api -t qu-guest-synchronizer-api:latest .

    kind load docker-image qu-guest-backend:latest --name queue-up
    kind load docker-image qu-guest-frontend:latest --name queue-up
    kind load docker-image qu-guest-synchronizer-api:latest --name queue-up
}

function build_authenticator() {
    gum format "# Building authenticator"
    docker buildx build -f ./apps/qu_authenticator_api/Dockerfile --target qu_authenticator_api -t qu-authenticator-api:latest .

    kind load docker-image qu-authenticator-api:latest --name queue-up
}

options=("All" "Admin/Organiser" "Guest")

# Use gum to prompt the user
choice=$(gum choose "${options[@]}" --header "Which part of the system do you wish to run?")

case "$choice" in
    All)
        create_cluster
        build_admin_organiser
        build_guest
        build_authenticator

        gum format  "# Applying k8 deployments and services"
        kubectl apply -f k8 -R
        ;;
    Admin/Organiser)
        create_cluster
        build_admin_organiser
        build_authenticator

        cd ./k8
        gum format  "# Applying admin/organiser deployments and services"
        ./+admin-organiser-setup.sh
        ;;
    Guest)
        create_cluster
        build_guest
        build_authenticator

        cd ./k8
        gum format  "# Applying guest deployments and services"
        ./+guest-setup.sh
        ;;
    *)
        ;;
esac
