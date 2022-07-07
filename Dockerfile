FROM ruby:3.0.4-alpine

RUN mkdir -p /app
WORKDIR /app

RUN apk --update --upgrade add git postgresql-dev imagemagick build-base xz-dev libc6-compat tzdata less \
    nodejs yarn vips \
    curl unzip \
    linux-headers \
    && rm -rf /var/cache/apk/*

EXPOSE 3000
