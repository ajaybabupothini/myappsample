FROM ghcr.io/actions/actions-runner:latest

ARG BUILDKIT_VERSION=v0.12.5

# Install buildctl and buildctl-daemonless.sh
RUN curl -sL https://github.com/moby/buildkit/releases/download/${BUILDKIT_VERSION}/buildkit-${BUILDKIT_VERSION}.linux-amd64.tar.gz \
    | tar -xz -C /tmp && \
    mkdir -p /home/runner/.local/bin && \
    mv /tmp/bin/buildctl /home/runner/.local/bin/ && \
    mv /tmp/bin/buildctl-daemonless.sh /home/runner/.local/bin/ && \
    chmod +x /home/runner/.local/bin/buildctl*

ENV PATH="/home/runner/.local/bin:$PATH"
ENV BUILDKITD_FLAGS="--oci-worker-no-process-sandbox"

USER runner
