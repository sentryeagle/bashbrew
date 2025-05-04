# bashbrew

[![Docker](../../actions/workflows/docker.yml/badge.svg)](../../actions/workflows/docker.yml)

Canonical Build Tool for the Official Docker Images.

## ⚙️ Getting Started

You'll need [Docker](https://www.docker.com/get-started/), [Visual Studio Code](https://code.visualstudio.com) and the [Dev Containers](https://aka.ms/vscode-remote/download/containers) extension installed.

> [!IMPORTANT]  
> An unaddressed [bug](https://github.com/microsoft/WSL/issues/4739) within the [Windows Subsystem for Linux (WSL)](https://aka.ms/wsl) disrupts the communication of file modifications initiated by Windows applications to Linux applications, thereby hindering Docker functionality on Windows machines. A practical workaround involves working directly within the WSL file system instead of the Windows file system. To do this, open a terminal and direct it to your home folder in WSL by using the command `wsl --cd ~`. Then follow the instructions below.

### Clone the Repository

First, clone the repository from GitHub:

```sh
$ git clone https://github.com/sentryeagle/bashbrew.git
```

### Open the Repository

Then verify **Docker** is running. Once it is running, open the cloned repository in **Visual Studio Code**.

```sh
$ code bashbrew
```

> [!NOTE]
> The repository contains a [`devcontainer.json`](.devcontainer) file that will set up the development environment. Therefore, when prompted, click _Reopen in Container_.

## 🛠️ Build System (Makefile)

The project includes a `Makefile` with the following commands:

### Build

Builds the Docker image from the current directory.

```sh
$ make
```

### Push

Pushes the Docker image into the OCI Registry.

```sh
$ make push
```

### Run

Runs the Docker image with the specified arguments. The current working directory (CWD) is mounted as a volume at `/mnt/local`.

```sh
$ make run -- --help  # Shows help
$ make run -- <args>  # Runs with custom arguments
```

### Clean

Removes all dangling Docker images (untagged images that are no longer referenced).

```sh
$ make clean
```

## 🧪 Example - Local

```sh
$ sh examples/distributions/example.sh

'debian/bookworm'
'debian/bullseye'
'debian/sid'
'debian/trixie'
'ubuntu/focal'
'ubuntu/jammy'
'ubuntu/noble'
'ubuntu/oracular'
'ubuntu/plucky'
```

## 🧪 Example - Container

```sh
$ docker run --rm --volume ${PWD}:/mnt/local ghcr.io/sentryeagle/bashbrew:latest --help
```

## 📖 Documentation

Below you will find a list of documentation for tools used in this project.

- **bashbrew**: Canonical Build Tool for the Official Docker Images - [Docs](https://github.com/docker-library/bashbrew)
- **Docker**: Container Application Development Tool - [Docs](https://docs.docker.com)
- **GitHub Actions**: Automation, Customization, and Execution of Software Development Workflows - [Docs](https://docs.github.com/en/actions)
- **Development Containers**: Open Specification for Enriching Containers with Development Specific Content and Settings - [Docs](https://www.containers.dev)

## 🐛 Found a Bug?

Thank you for your message! Please fill out a [bug report](../../issues/new?assignees=&labels=&template=bug_report.md&title=).

## 📖 License

This project is licensed under the [European Union Public License 1.2](https://interoperable-europe.ec.europa.eu/sites/default/files/custom-page/attachment/2020-03/EUPL-1.2%20EN.txt).