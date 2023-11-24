# Python Environment Setup

This repository contains a `setup.sh` script that sets up a Python environment based on a `.pyplatx` configuration file.

## Usage
To use the setup.sh script, run the following command in your terminal:

```bash
./setup.sh
```

This will set up the Python environment based on the .pyplatx configuration file.

## Configuration

The `.pyplatx` configuration file specifies the Python versions to install, the global Python version, the build dependencies, and the `pyenv` build settings. Here's an example:

```yaml
# .pyplatx - Python environment config file

# List of Python versions to install 
python_envs:
  - 3.10.13
  - 3.11.6

# Global Python version
global_version: 3.11.6

# Build dependencies
build_packages:
  - build-essential 
  - libssl-dev 
  - zlib1g-dev
  - libbz2-dev
  - libreadline-dev
  - libsqlite3-dev
  - curl
  - libncursesw5-dev
  - xz-utils
  - tk-dev
  - libxml2-dev
  - libxmlsec1-dev
  - libffi-dev
  - liblzma-dev

# Pyenv build settings  
build_env_vars:
  PYENV_BUILD_MIRROR_URL: https://pyenv.run
  PYENV_BUILD_SKIP_MIRROR: 1
```

## Testing with Docker

To streamline the testing process and ensure consistent environments, Docker can be employed to run the scripts in isolated containers. Follow the steps below to test the `setup.sh` script using Docker.

### Prerequisites

Before proceeding, ensure that Docker is installed on your system. If not, refer to the [official Docker installation documentation](https://docs.docker.com/get-docker/).

### Instructions

1. **Build the Docker Image:**
   ```bash
   docker build -t script-testing .
   ```
   This command constructs a Docker image named `script-testing` based on the provided Dockerfile.

2. **Run the `setup.sh` Script in a Docker Container:**
   ```bash
   docker run script-testing ./setup.sh
   ```
   Execute the `setup.sh` script in a Docker container to isolate its dependencies.

### Manual Testing

For manual testing or interactive inspection of the script's behavior, you can run a Docker container with an interactive shell:

```bash
docker run -it script-testing /bin/bash
```

This opens a Bash shell inside the container, allowing you to manually execute and test the `setup.sh` script within the container environment.

### Verify Results

After running the `setup.sh` script in Docker containers, manually verify the results to ensure they align with the expected outcomes.

By following these instructions, you can efficiently test the `setup.sh` script using Docker and manually inspect its behavior within isolated environments.