# Use official NGINX image
FROM nginx:alpine

# Copy static files into the container
COPY ./dist/. /usr/share/nginx/html

# Expose port 80
EXPOSE 8080

# NGINX will automatically serve files from /usr/share/nginx/html
