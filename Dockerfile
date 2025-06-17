FROM ghcr.io/actions/actions-runner:latest

ARG BUILDKIT_VERSION=v0.22.0

USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl uidmap iproute2 iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user (UID 1000, like GitHub runner)
RUN useradd -m -u 1000 user

# Install buildctl and buildkitd (no root needed at runtime)
RUN curl -sL https://github.com/moby/buildkit/releases/download/${BUILDKIT_VERSION}/buildkit-${BUILDKIT_VERSION}.linux-amd64.tar.gz \
    | tar -xz -C /usr/local && \
    curl -sL https://raw.githubusercontent.com/moby/buildkit/${BUILDKIT_VERSION}/cmd/buildctl/buildctl-daemonless.sh \
    -o /usr/local/bin/buildctl-daemonless.sh && \
    chmod +x /usr/local/bin/buildctl*

ENV PATH="/usr/local/bin:$PATH"

USER 1000
ENV HOME=/home/user
ENV USER=user
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV TMPDIR=/home/user/.local/tmp
ENV BUILDKITD_FLAGS="--oci-worker-no-process-sandbox"

WORKDIR /home/user

# This entrypoint doesn't start buildkitd directly; instead, the GitHub Action calls buildctl-daemonless.sh
ENTRYPOINT ["/bin/bash"]
