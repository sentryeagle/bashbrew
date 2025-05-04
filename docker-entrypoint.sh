#!/usr/bin/env bash
set -Eeuo pipefail

readonly BASHBREW_BASE_DIR="/mnt/local/.bashbrew"
readonly DOCKER_OFFICIAL_IMAGES_DIR="${BASHBREW_BASE_DIR}/docker/official-images"

# Clone 'docker-library/official-images' repository.
if [ ! -d "${DOCKER_OFFICIAL_IMAGES_DIR}" ]; then
    git clone --quiet https://github.com/docker-library/official-images.git "${DOCKER_OFFICIAL_IMAGES_DIR}"
else
    cd "${DOCKER_OFFICIAL_IMAGES_DIR}" && git pull --quiet --strategy-option=theirs
fi

# Set recursive read/write permissions for all users on the 'BASHBREW_BASE_DIR' directory.
# This is required because the Docker container only has a root user, and files created
# in the mounted volume would otherwise only be accessible by root, causing problems
# for local users who need to manage these files (like deleting cached data).
chmod --recursive a+rw "${BASHBREW_BASE_DIR}"

export BASHBREW_CACHE="${BASHBREW_BASE_DIR}/cache/"
export BASHBREW_LIBRARY="${DOCKER_OFFICIAL_IMAGES_DIR}/library"

# Run 'bashbrew'.
bashbrew "$@"