FROM ruby:2-alpine

ARG BACKUP_VERSION=5.0.0.beta.3

RUN \
  apk add --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql \
    curl-dev \
    readline-dev \
    openssl \
    gnupg \
    gzip \
    tar \
    zlib-dev && \
  echo "http://dl-cdn.alpinelinux.org/alpine/v3.16/community" >> /etc/apk/repositories && \
  apk add --no-cache postgresql15 postgresql15-client postgresql15-contrib && \
  rm -rf /var/cache/apk/*

RUN gem install backup -v ${BACKUP_VERSION}
