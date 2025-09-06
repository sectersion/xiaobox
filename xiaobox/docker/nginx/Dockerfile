# Use lightweight nginx alpine base
FROM nginx:alpine

# Remove the default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your site files into nginx's html directory
COPY /xiaobox/public/ /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80

# Launch nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
