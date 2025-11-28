# Docker Deployment for Wanabiso2k26

This project includes a Docker configuration for building and serving the Hugo site.

## Prerequisites

- Docker
- Docker Compose (optional, for easier local execution)

## Building and Running

### Using Docker Compose (Recommended)

1. Build and start the container:

   ```bash
   docker-compose up -d --build
   ```

2. Access the site at [http://localhost:8080](http://localhost:8080).

### Using Docker CLI

1. Build the image:

   ```bash
   docker build -t wanabiso2k26 .
   ```

2. Run the container:

   ```bash
   docker run -p 8080:80 wanabiso2k26
   ```

## Configuration

The `Dockerfile` is configured to build the site with `baseURL = /`. This ensures the site works correctly at the root of the container (e.g., `http://localhost:8080/`).

If you need to deploy to a subdirectory (e.g., `https://example.com/wanabiso2k26/`), you should modify the `Dockerfile` or override the command:

```dockerfile
# In Dockerfile
RUN hugo --minify --destination /public --baseURL https://example.com/wanabiso2k26/
```
