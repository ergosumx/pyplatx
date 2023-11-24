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