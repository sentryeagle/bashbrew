# Makefile for Docker-based project management
# ============================================

# Variables
# ---------

# Docker: Command to invoke Docker.
DOCKER := docker

# Docker Buildx: Image Args
OCI_REGISTRY ?= docker.io
OCI_REPOSITORY ?= sentryeagle/bashbrew
OCI_TAG ?= latest

OCI_TITLE ?= bashbrew
OCI_DESCRIPTION ?= Canonical Build Tool for the Official Docker Images.
OCI_SOURCE ?= https://github.com/sentryeagle/bashbrew.git
OCI_LICENSE ?= EUPL-1.2
OCI_VENDOR ?= SentryEagle

# Docker Buildx: Build Args
GOLANG_VERSION ?= 1
BUILDPACK_DEPS_VERSION ?= plucky-scm
BASHBREW_VERSION ?= latest

# Docker Buildx: Bake Command
DOCKER_BUILDX_BAKE_CMD = \
	OCI_REGISTRY="$(OCI_REGISTRY)" \
	OCI_REPOSITORY="$(OCI_REPOSITORY)" \
	OCI_TAG="$(OCI_TAG)" \
	OCI_TITLE="$(OCI_TITLE)" \
	OCI_DESCRIPTION="$(OCI_DESCRIPTION)" \
	OCI_SOURCE="$(OCI_SOURCE)" \
	OCI_LICENSE="$(OCI_LICENSE)" \
	OCI_VENDOR="$(OCI_VENDOR)" \
	GOLANG_VERSION="$(GOLANG_VERSION)" \
	BUILDPACK_DEPS_VERSION="$(BUILDPACK_DEPS_VERSION)" \
	BASHBREW_VERSION="$(BASHBREW_VERSION)" \
	  $(DOCKER) buildx bake

# Make: Current working directory of the Makefile.
# See: https://stackoverflow.com/a/73509979
ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Logic
# -----

# Run target.
# See: https://stackoverflow.com/a/14061796
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

# Phony targets
# -------------
# Declare phony targets to avoid conflicts with files of the same name.
.PHONY: build push run clean

# Build target
# ------------
# Builds the Docker Image.
build : 
	$(DOCKER_BUILDX_BAKE_CMD)

# Push target
# ------------
# Pushes the Docker Image to the OCI Registry.
push : 
	$(DOCKER_BUILDX_BAKE_CMD) --push

# Run target
# ----------
# Runs the Docker Image.
run:
	@$(DOCKER) run --rm --volume "$(ROOT_DIR):/mnt/local" "$(OCI_REGISTRY)/$(OCI_REPOSITORY):$(OCI_TAG)" $(RUN_ARGS)

# Clean target
# ------------
# Remove all dangling images.
clean :
	$(DOCKER) rmi --force $(shell $(DOCKER) images --quiet --filter "dangling=true")