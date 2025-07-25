# Docker Images

A collection of custom Docker images for development and deployment workflows.

## Images

### Astral UV with Git (`astral-git`)

A Docker image based on [Astral's UV](https://github.com/astral-sh/uv) Python package manager with Git and Git LFS support added.

#### Features

- 🚀 **Fast Python package management** with UV
- 🔄 **Git support** for version control operations
- 📦 **Git LFS support** for large file handling
<!-- - 🔒 **Security-focused** with non-root user -->
- 🏗️ **Multi-architecture** support (amd64/arm64)
- 📋 **Proper OCI labels** for metadata

#### Usage

Pull the latest image:

```bash
docker pull ghcr.io/t-samuelg/docker-images/astral-git:latest
```

#### Examples

**Basic Python project setup:**

```bash
# Run interactively
docker run -it --rm -v $(pwd):/app ghcr.io/t-samuelg/docker-images/astral-git:latest

# Inside the container
uv init my-project
cd my-project
uv add requests
uv run python -c "import requests; print('Hello, World!')"
```

**Clone and work with a Git repository:**

```bash
# Mount your SSH keys for Git authentication
docker run -it --rm \
  -v $(pwd):/app \
  -v ~/.ssh:/home/uvuser/.ssh:ro \
  ghcr.io/t-samuelg/docker-images/astral-git:latest

# Inside the container
git clone git@github.com:user/repo.git
cd repo
uv sync
uv run python main.py
```

**CI/CD Pipeline usage:**

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    container: ghcr.io/t-samuelg/docker-images/astral-git:latest
    steps:
      - uses: actions/checkout@v4
      - run: uv sync
      - run: uv run pytest
```

#### Environment Variables

- `PYTHONUNBUFFERED=1` - Ensures Python output is sent straight to terminal
- `UV_CACHE_DIR=/tmp/uv-cache` - UV cache directory location

#### Security

This image runs as a non-root user (`uvuser`) for enhanced security. The working directory is `/app` and is owned by the `uvuser`.

## Building Locally

To build the image locally:

```bash
docker build -f astral_git.dockerfile -t astral-git .
```

## CI/CD

Images are automatically built and published to GitHub Container Registry via GitHub Actions on:
- Push to `main` branch (tagged as `latest`)
- Pull requests (tagged with PR number)
- Releases (tagged with semantic versioning)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the Docker image
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.