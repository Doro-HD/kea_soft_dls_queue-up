
docker buildx build -f frontends.Dockerfile --target qu_admin_organiser_frontend -t qu-admin-organiser-frontend:latest .
docker buildx build -f frontends.Dockerfile --target qu_guest_frontend -t qu-guest-frontend:latest .

kind load docker-image qu-admin-organiser-frontend:latest --name queue-up
kind load docker-image qu-guest-frontend:latest --name queue-up