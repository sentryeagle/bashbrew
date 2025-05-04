ARG GOLANG_VERSION="1"
ARG BUILDPACK_DEPS_VERSION="plucky-scm"

FROM golang:${GOLANG_VERSION} AS bashbrew

# Install 'bashbrew'.
ARG BASHBREW_VERSION="latest"
RUN go install github.com/docker-library/bashbrew/cmd/bashbrew/...@${BASHBREW_VERSION}

FROM buildpack-deps:${BUILDPACK_DEPS_VERSION} AS runtime

# Copy 'bashbrew' into 'bin' directory.
COPY --from=bashbrew /go/bin/bashbrew /usr/local/bin/bashbrew

VOLUME /mnt/local
WORKDIR /docker/container

# Copy 'docker-entrypoint.sh' into work directory.
COPY docker-entrypoint.sh docker-entrypoint.sh

# Make 'docker-entrypoint.sh' executable.
RUN chmod +x docker-entrypoint.sh

# Run 'docker-entrypoint.sh'.
ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]