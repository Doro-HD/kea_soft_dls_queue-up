# Build images
docker buildx build -f backends.Dockerfile --target qu_admin_organiser_backend -t qu-admin-organiser-backend:latest .
docker buildx build -f backends.Dockerfile --target qu_admin_organiser_synchronizer_api -t qu-admin-organiser-synchronizer-api:latest .

docker buildx build -f backends.Dockerfile --target qu_guest_backend -t qu-guest-backend:latest .
docker buildx build -f backends.Dockerfile --target qu_guest_synchronizer_api -t qu-guest-synchronizer-api:latest .

docker buildx build -f backends.Dockerfile --target qu_authenticator_api -t qu-authenticator-api:latest .


# Load images into kind
kind load docker-image qu-admin-organiser-backend:latest --name queue-up
kind load docker-image qu-admin-organiser-synchronizer-api:latest --name queue-up

kind load docker-image qu-guest-backend:latest --name queue-up
kind load docker-image qu-guest-synchronizer-api:latest --name queue-up

kind load docker-image qu-authenticator-api:latest --name queue-up
