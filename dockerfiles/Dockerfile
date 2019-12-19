FROM ruby:2.6.5-alpine3.10

ENV LANG C.UTF-8

RUN mkdir -p /srv/www/current
WORKDIR /srv/www/current

RUN apk upgrade --no-cache && \
    apk add --update --no-cache \
      git \
      nodejs \
      tzdata \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      mysql-client \
      mysql-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev \
      less \
      npm

RUN npm install -g yarn

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

RUN bundle config build.nokogiri --use-system-libraries

ENTRYPOINT [ \
  "prehook", "ruby -v", "--", \
  "prehook", "bundle install -j4", "--", \
  "prehook", "yarn", "--"]
