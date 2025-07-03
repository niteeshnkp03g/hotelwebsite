# Use Nginx to serve static content
FROM nginx:alpine

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy your site content into Nginx's default directory
COPY . /usr/share/nginx/html

# Expose default HTTP port
EXPOSE 80
