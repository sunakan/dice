FROM ruby:2.6.1-slim-stretch

RUN apt-get update -qq && apt-get install -y locales build-essential libpq-dev nodejs

RUN sed -i 's/#.*ja_JP\.UTF/ja_JP\.UTF/' /etc/locale.gen
RUN locale-gen && update-locale LANG=ja_JP.UTF-8

ENV APP_DIR /app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR

COPY . $APP_DIR

RUN gem install bundler
RUN bundle install --path=vendor/bundle
