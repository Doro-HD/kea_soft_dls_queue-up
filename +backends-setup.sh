docker buildx build -f backends.Dockerfile --target ff_admin_organiser_backend -t ff-admin-organiser-backend:latest .
docker buildx build -f backends.Dockerfile --target ff_guest_backend -t ff-guest-backend:latest .
docker buildx build -f backends.Dockerfile --target ff_authenticator_api -t ff-authenticator-api:latest .
docker buildx build -f backends.Dockerfile --target ff_synchronizer_api -t ff-synchronizer-api:latest .

kind load docker-image ff-admin-organiser-backend:latest --name fire-flux
kind load docker-image ff-guest-backend:latest --name fire-flux
kind load docker-image ff-authenticator-api:latest --name fire-flux
kind load docker-image ff-synchronizer-api:latest --name fire-flux
