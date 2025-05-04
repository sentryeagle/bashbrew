# Image Args
variable "OCI_REGISTRY" { default = "docker.io" }
variable "OCI_REPOSITORY" { default = "sentryeagle/bashbrew" }
variable "OCI_TAG" { default = "" }

variable "OCI_TITLE" { default = "bashbrew" }
variable "OCI_DESCRIPTION" { default = "Canonical Build Tool for the Official Docker Images." }
variable "OCI_SOURCE" { default = "https://github.com/sentryeagle/bashbrew.git" }
variable "OCI_LICENSE" { default = "EUPL-1.2" }
variable "OCI_VENDOR" { default = "SentryEagle" }

# Build Args
variable "GOLANG_VERSION" { default = "1" }
variable "BUILDPACK_DEPS_VERSION" { default = "plucky-scm" }
variable "BASHBREW_VERSION" { default = "latest" }

# Default Group
group "default" {
    targets = [ "bashbrew" ]
}

# Bashbrew Target
target "bashbrew" {
    dockerfile = "bashbrew.Dockerfile"
    
    # Arguments
    args = {
        "GOLANG_VERSION" = GOLANG_VERSION
        "BUILDPACK_DEPS_VERSION" = BUILDPACK_DEPS_VERSION

        "BASHBREW_VERSION" = BASHBREW_VERSION
    }

    # Cache
    no-cache = true
    pull = true

    # Description
    description = OCI_DESCRIPTION
    
    # Tags
    tags = [ 
        "${OCI_REGISTRY}/${OCI_REPOSITORY}:latest",
        notequal("", OCI_TAG) ? "${OCI_REGISTRY}/${OCI_REPOSITORY}:${OCI_TAG}" : ""
    ]

    # Metadata
    labels = {
        "org.opencontainers.image.title" = OCI_TITLE
        "org.opencontainers.image.description" = OCI_DESCRIPTION
        "org.opencontainers.image.source" = OCI_SOURCE
        "org.opencontainers.image.licenses" = OCI_LICENSE
        "org.opencontainers.image.vendor" = OCI_VENDOR
    }
}