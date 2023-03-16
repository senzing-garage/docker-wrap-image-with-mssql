# docker-wrap-with-mssql

## Synopsis

Wrap a Docker image with support for MsSQL database.

## Overview

The contents of this repository are used to extend existing Docker images
to enable them to work with the MsSQL database.
By itself, the
[Dockerfile](Dockerfile)
is not useful.
Rather, it can be used in the method described below,
[Create containers](#create-containers),
to add files to an existing Docker image.

### Contents

1. [Overview](#overview)
    1. [Preamble](#preamble)
    1. [Legend](#legend)
    1. [Related artifacts](#related-artifacts)
    1. [Expectations](#expectations)
1. [Create containers](#create-containers)
1. [Develop](#develop)
    1. [Prerequisites for development](#prerequisites-for-development)
    1. [Clone repository](#clone-repository)
    1. [Build Docker image](#build-docker-image)
1. [Examples](#examples)
1. [Advanced](#advanced)
1. [Errors](#errors)
1. [References](#references)
1. [License](#license)

### Preamble

At [Senzing](http://senzing.com),
we strive to create GitHub documentation in a
"[don't make me think](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/dont-make-me-think.md)" style.
For the most part, instructions are copy and paste.
Whenever thinking is needed, it's marked with a "thinking" icon :thinking:.
Whenever customization is needed, it's marked with a "pencil" icon :pencil2:.
If the instructions are not clear, please let us know by opening a new
[Documentation issue](https://github.com/Senzing/template-python/issues/new?template=documentation_request.md)
describing where we can improve.   Now on with the show...

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

### Related artifacts

### Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker.md)

## Create containers

The following steps show how to wrap existing containers with MsSQL prerequisites.

1. Get versions of Docker images.
   Example:

    ```console
    curl -X GET \
        --output /tmp/docker-versions-stable.sh \
        https://raw.githubusercontent.com/Senzing/knowledge-base/main/lists/docker-versions-stable.sh
    source /tmp/docker-versions-stable.sh

    ```

1. List the Docker images and their
   [corresponding environment variable name](https://github.com/Senzing/knowledge-base/blob/main/lists/docker-versions-stable.sh).

   Format: `repository`;`tag`;`user` where `user` defaults to `1001`.

   Example:

    ```console
    export BASE_IMAGES=( \
      "senzing/entity-search-web-app-console;${SENZING_DOCKER_IMAGE_VERSION_ENTITY_SEARCH_WEB_APP_CONSOLE:-latest}" \
      "senzing/redoer;${SENZING_DOCKER_IMAGE_VERSION_REDOER:-latest};1001" \
      "senzing/senzing-api-server;${SENZING_DOCKER_IMAGE_VERSION_SENZING_API_SERVER:-latest}" \
      "senzing/senzing-console;${SENZING_DOCKER_IMAGE_VERSION_SENZING_CONSOLE:-latest}" \
      "senzing/senzing-poc-server;${SENZING_DOCKER_IMAGE_VERSION_SENZING_POC_SERVER:-latest}" \
      "senzing/senzing-tools;${SENZING_DOCKER_IMAGE_VERSION_SENZING_TOOLS:-latest}" \
      "senzing/senzingapi-runtime;${SENZING_DOCKER_IMAGE_VERSION_SENZINGAPI_RUNTIME:-latest}" \
      "senzing/senzingapi-tools;${SENZING_DOCKER_IMAGE_VERSION_SENZINGAPI_TOOLS:-latest}" \
      "senzing/sshd;${SENZING_DOCKER_IMAGE_VERSION_SSHD:-latest};0" \
      "senzing/stream-loader;${SENZING_DOCKER_IMAGE_VERSION_STREAM_LOADER:-latest}" \
      "senzing/xterm;${SENZING_DOCKER_IMAGE_VERSION_XTERM:-latest}" \
    )

    ```

1. Build each of the MsSQL compatible docker images in the list.
   Example:

    ```console
    for BASE_IMAGE in ${BASE_IMAGES[@]}; \
    do \
        IFS=";" read -r -a BASE_IMAGE_DATA <<< "${BASE_IMAGE}"
        BASE_IMAGE_NAME="${BASE_IMAGE_DATA[0]}"
        BASE_IMAGE_VERSION="${BASE_IMAGE_DATA[1]}"
        BASE_IMAGE_USER="${BASE_IMAGE_DATA[2]}"
        docker pull ${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}
        docker build \
            --build-arg BASE_IMAGE=${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION} \
            --build-arg USER=${BASE_IMAGE_USER:-1001} \
            --tag ${BASE_IMAGE_NAME}-mssql:${BASE_IMAGE_VERSION} \
            https://github.com/Senzing/docker-wrap-image-with-mssql.git#main

    done

    ```

## Develop

The following instructions are used when modifying and building the Docker image.

### Prerequisites for development

:thinking: The following tasks need to be complete before proceeding.
These are "one-time tasks" which may already have been completed.

1. The following software programs need to be installed:
    1. [git](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-git.md)
    1. [make](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-make.md)
    1. [docker](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-wrap-image-with-mssql
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Using the environment variables values just set, follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/clone-repository.md) to install the Git repository.

### Build Docker image

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build \
      --tag senzing/stream-loader \
      https://github.com/senzing/docker-wrap-image-with-mssql.git#main
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/docker-wrap-image-with-mssql .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo --preserve-env make docker-build
    ```

## Examples

## Advanced

## Errors

1. See [docs/errors.md](docs/errors.md).

## References

## License

View
[license information](https://senzing.com/end-user-license-agreement/)
for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the
[Senzing GitHub community](https://github.com/Senzing/)
under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

Further, as with all Docker images,
this likely also contains other software which may be under other licenses
(such as Bash, etc. from the base distribution,
along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage,
it is the image user's responsibility to ensure that any use of this image complies
with any relevant licenses for all software contained within.
