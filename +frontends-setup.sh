
docker buildx build -f frontends.Dockerfile --target ff_admin_organiser_frontend -t ff-admin-organiser-frontend:latest .
docker buildx build -f frontends.Dockerfile --target ff_guest_frontend -t ff-guest-frontend:latest .

kind load docker-image ff-admin-organiser-frontend:latest --name fire-flux
kind load docker-image ff-guest-frontend:latest --name fire-flux