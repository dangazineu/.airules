#!/bin/bash
#
# This script automates the local testing process using Docker.
# It builds the Docker image from the project root and runs the test container.
#

set -e # Exit immediately if a command fails

# Determine the project root directory, which is one level up from this script.
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

IMAGE_NAME="airules-tester"

echo "--- Building Docker test image: $IMAGE_NAME ---"
echo "Project Root: $PROJECT_ROOT"
echo "Dockerfile:   $SCRIPT_DIR/Dockerfile"

# Build the Docker image using the project root as the context.
docker build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/Dockerfile" "$PROJECT_ROOT"

echo ""
echo "--- Running tests in Docker container ---"
# Using --rm to automatically remove the container after it exits.
docker run --rm "$IMAGE_NAME" bash /app/tests/tests.sh

echo ""
echo "--- Local test run completed successfully! ---"