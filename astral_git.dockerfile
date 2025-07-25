FROM ghcr.io/astral-sh/uv:0.8-python3.13-bookworm-slim

# Add metadata labels
LABEL org.opencontainers.image.title="Astral UV with Git"
LABEL org.opencontainers.image.description="UV Python package manager with Git and Git LFS support"
LABEL org.opencontainers.image.vendor="Custom"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/t-samuelg/docker-images"

# Install Git and Git LFS with minimal overhead
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        git-lfs \
        ca-certificates \
    && git lfs install --system \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set Git configuration for better container usage
RUN git config --system init.defaultBranch main && \
    git config --system user.name "Docker User" && \
    git config --system user.email "docker@example.com" && \
    git config --system safe.directory '*'

# # Create a non-root user for security
# RUN groupadd -r uvuser && useradd -r -g uvuser -d /home/uvuser -s /bin/bash uvuser && \
#     mkdir -p /home/uvuser && \
#     chown -R uvuser:uvuser /home/uvuser

# Set working directory
WORKDIR /app

# # Change to non-root user
# USER uvuser

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV UV_CACHE_DIR=/tmp/uv-cache
