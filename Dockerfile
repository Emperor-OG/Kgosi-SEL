# Use the official lightweight Nginx image
FROM nginx:alpine

# Remove the default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your campaign's index.html into the web root
COPY index.html /usr/share/nginx/html/index.html

# Create a custom Nginx configuration to listen on port 8080
# (Cloud Run expects the container to listen on $PORT, default 8080)
RUN echo 'server { \
    listen 8080; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose port 8080
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
