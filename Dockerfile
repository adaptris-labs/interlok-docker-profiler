FROM azul/zulu-openjdk-alpine:8

LABEL maintainer="Adaptris"

ARG BASE_URL=https://development.adaptris.net/installers/Interlok/latest-stable/
ARG INTERLOK_VERSION=3.10-SNAPSHOT
ARG java_tool_opts

ENV JAVA_TOOL_OPTIONS=$java_tool_opts
# JAVA_HOME is set wrong on the latest 8-jre image.
ENV JAVA_HOME=/usr/lib/jvm/zulu8

RUN apk add --no-cache --update ca-certificates bash curl unzip su-exec && \
    addgroup -S interlok && \
    adduser -S interlok -G interlok && \
    mkdir -p /opt/interlok/logs

COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR /opt/interlok

RUN  \
    curl -fsSL -o base-filesystem.zip -q ${BASE_URL}/base-filesystem.zip && \
    unzip -o -q  base-filesystem.zip && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf *.zip

EXPOSE 8080
EXPOSE 5555

ADD lib /opt/interlok/lib
ADD webapps /opt/interlok/webapps
ADD config /opt/interlok/config


ENV JVM_ARGS=-Xmx1024m
ENV JAVA_OPTS=-Dsun.net.inetaddr.ttl=30
ENV INTERLOK_OPTS=bootstrap.properties
ENV INTERLOK_BASE=/opt/interlok
ENV JAVA_TOOL_OPTIONS=""

ENTRYPOINT ["/docker-entrypoint.sh"]
