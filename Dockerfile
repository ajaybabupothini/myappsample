# syntax=docker/dockerfile:1
# Use the specified GitHub Actions runner image as the base
FROM ghcr.io/actions/actions-runner:latest

# Attempt to install Docker Buildx by copying a binary from the specified moby/buildkit image.
# IMPORTANT: docker/buildx-bin:latest is the official image for the Buildx CLI plugin.
# moby/buildkit is the BuildKit daemon. Copying '/buildx' from moby/buildkit might not
# correctly provide the 'docker buildx' CLI plugin.
# If you only need the 'docker buildx' CLI, consider using:
# COPY --from=docker/buildx-bin:latest /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=moby/buildkit:rootless /buildx /usr/libexec/docker/cli-plugins/docker-buildx

# Ensure the copied binary is executable
RUN chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

# Verify that Docker Buildx is installed and callable
RUN docker buildx version