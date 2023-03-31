#!/bin/bash

# Build
docker build -t searchgpt .

# Extract environment variables from Azure DevOps
ENV_VARS=$(azd env get-values)

# Parse the output and set each variable using the --env option
echo "$ENV_VARS" | while IFS='=' read -r key value; do
    value=$(echo "$value" | sed 's/^"//' | sed 's/"$//')
    docker_run_opts+=" --env $key=$value"
done

# Run the Docker container with the environment variables
docker run $docker_run_opts -p 8000:8000 searchgpt
