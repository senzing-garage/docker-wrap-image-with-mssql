# docker-wrap-with-mssql

## :no_entry: Deprecated

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Synopsis

Wrap a Docker image with support for MsSQL database.

## Overview

The contents of this repository are used to extend existing Docker images
to enable them to work with the MsSQL database.
By itself, the [Dockerfile] is not useful.
Rather, it can be used in the method described below,
[Create containers], to add files to an existing Docker image.

### Contents

1. [Overview]
   1. [Preamble]
   1. [Expectations]
1. [Create containers]
1. [License]
1. [References]

## Preamble

At [Senzing], we strive to create GitHub documentation in a
"[don't make me think]" style. For the most part, instructions are copy and paste.
[Icons] are used to signify additional actions by the user.
If the instructions are not clear, please let us know by opening a new
[Documentation issue] describing where we can improve. Now on with the show...

### Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker]

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

1. :pencil2: List the Docker images and their [corresponding environment variable name].

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
           https://github.com/senzing-garage/docker-wrap-image-with-mssql.git#main
   done

   ```

## License

View [license information] for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the
[Senzing GitHub community] under the [Apache License 2.0].

Further, as with all Docker images,
this likely also contains other software which may be under other licenses
(such as Bash, etc. from the base distribution,
along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage,
it is the image user's responsibility to ensure that any use of this image complies
with any relevant licenses for all software contained within.

## References

- [Development]
- [Errors]
- [Examples]
- [Legend]

[Apache License 2.0]: https://www.apache.org/licenses/LICENSE-2.0
[corresponding environment variable name]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/docker-versions-stable.sh
[Create containers]: #create-containers
[Development]: docs/development.md
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[Dockerfile]: Dockerfile
[Documentation issue]: https://github.com/senzing-garage/docker-wrap-image-with-mssql/issues/new?template=documentation_request.md
[don't make me think]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/dont-make-me-think.md
[Errors]: docs/errors.md
[Examples]: docs/examples.md
[Expectations]: #expectations
[Icons]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/legend.md
[Legend]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/legend.md
[license information]: https://senzing.com/end-user-license-agreement/
[License]: #license
[Overview]: #overview
[Preamble]: #preamble
[References]: #references
[Senzing Garage]: https://github.com/senzing-garage
[Senzing GitHub community]: https://github.com/senzing-garage/
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[Senzing]: https://senzing.com/
