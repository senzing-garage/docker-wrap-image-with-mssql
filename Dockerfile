ARG BASE_IMAGE=debian:11.6-slim@sha256:98d3b4b0cee264301eb1354e0b549323af2d0633e1c43375d0b25c01826b6790
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2023-03-16

LABEL Name="senzing/wrap-with-mssql" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

USER root

# MsSQL support

ENV ACCEPT_EULA=Y

RUN apt-get update \
 && apt-get -y install \
      msodbcsql17 \
 && rm -rf /var/lib/apt/lists/*

RUN rm /opt/senzing/g2/sdk/python/senzing_governor.py || true

# Set/Reset the USER.

ARG USER=1005
USER ${USER}
