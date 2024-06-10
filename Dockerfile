FROM ruby:3.2-alpine

ARG BACKUP_VERSION=5.0.0.beta.3

# Add necessary dependencies
RUN apk add --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    curl-dev \
    readline-dev \
    openssl \
    gnupg \
    gzip \
    tar \
    zlib-dev \
    su-exec \
    tzdata \
    ca-certificates

# Download and install PostgreSQL 15
RUN apk add --no-cache --virtual .build-deps \
    wget \
    && wget --quiet https://ftp.postgresql.org/pub/source/v15.7/postgresql-15.7.tar.gz \
    && tar -xzf postgresql-15.7.tar.gz \
    && cd postgresql-15.7 \
    && ./configure --with-openssl \
    && make \
    && make install \
    && cd .. \
    && rm -rf postgresql-15.7* \
    && apk del .build-deps

RUN gem install backup -v ${BACKUP_VERSION}

# Add PostgreSQL binaries to PATH
ENV PATH="/usr/local/pgsql/bin:$PATH"

