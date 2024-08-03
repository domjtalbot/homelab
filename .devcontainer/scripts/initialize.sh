#!/bin/bash

ls -1

# Start both Docker build commands in the background
docker build -f ./.devcontainer/images/dockerfile.base-alpine -t homelab:base-alpine . &
docker build -f ./.devcontainer/images/dockerfile.base-debian -t homelab:base-debian . &

# Wait for all background jobs to finish
wait
