#base image
FROM ruby:2.7.2-alpine3.12 as base

WORKDIR /app

RUN apk update && apk add --no-cache \
    build-base \
    git \
    libcurl \
    linux-headers \
    ruby \
    openssl \
    postgresql-client \
    postgresql-dev \
    less

ENV BUNDLE_FORCE_RUBY_PLATFORM=1

RUN gem install bundler --version "2.2.1"

RUN bundle config set path '/bundle'

COPY Gemfile* ./
RUN bundle install

FROM base as development
RUN bundle install --clean --without production
COPY . ./

FROM base as production
ENV RAILS_ENV=production
ENV NODE_ENV=production

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

# Remove not used gems
RUN bundle install --clean --without development test

COPY . ./

#RUN bundle exec rake assets:precompile
#RUN bundle exec rake assets:clean

ENTRYPOINT [ "scripts/start" ]