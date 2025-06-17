FROM ghcr.io/actions/actions-runner:latest

ARG BUILDKIT_VERSION=v0.12.5

# Install buildctl binary
RUN curl -sL https://github.com/moby/buildkit/releases/download/${BUILDKIT_VERSION}/buildkit-${BUILDKIT_VERSION}.linux-amd64.tar.gz \
    | tar -xz -C /tmp && \
    mkdir -p /home/runner/.local/bin && \
    mv /tmp/bin/buildctl /home/runner/.local/bin/

# Download buildctl-daemonless.sh from source repo
RUN curl -sL https://raw.githubusercontent.com/moby/buildkit/${BUILDKIT_VERSION}/cmd/buildctl/buildctl-daemonless.sh \
    -o /home/runner/.local/bin/buildctl-daemonless.sh && \
    chmod +x /home/runner/.local/bin/buildctl-daemonless.sh

ENV PATH="/home/runner/.local/bin:$PATH"
ENV BUILDKITD_FLAGS="--oci-worker-no-process-sandbox"

USER runner
