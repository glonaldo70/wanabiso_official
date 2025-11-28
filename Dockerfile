# Stage 1: Build the site
FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src
COPY . .

# Build the site
# We override the baseURL to / so the site works at the root of the container (http://localhost:8080/)
# If you are deploying to a subdirectory, you can remove the --baseURL flag or set it to your subpath.
RUN hugo --minify --destination /public --baseURL /

# Stage 2: Serve the site
FROM httpd:2.4

# Create the directory structure
RUN mkdir -p /var/www/html/public

# Copy the built site from the builder stage
COPY --from=builder /public /var/www/html/public

# Fix permissions
RUN chmod -R 755 /var/www/html/public

# Copy the Apache configuration
COPY apache/laravel.conf /usr/local/apache2/conf/wanabiso.conf

# Configure Apache to use the new config and enable necessary modules
RUN sed -i \
    -e 's/#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/#LoadModule deflate_module/LoadModule deflate_module/' \
    -e 's/#LoadModule expires_module/LoadModule expires_module/' \
    -e '$aInclude conf/wanabiso.conf' \
    conf/httpd.conf

# Expose port 80
EXPOSE 80
