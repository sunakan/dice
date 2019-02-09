FROM ruby:2.6.1-slim-stretch

RUN apt-get update -qq && apt-get install -y locales build-essential libpq-dev nodejs wget

RUN sed -i 's/#.*ja_JP\.UTF/ja_JP\.UTF/' /etc/locale.gen
RUN locale-gen && update-locale LANG=ja_JP.UTF-8

# yarn(最新版はエラーがでる)
# https://github.com/yarnpkg/yarn/issues/6900
#RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
#    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#    apt-get update && apt-get install -y yarn
# old version
RUN wget https://nightly.yarnpkg.com/debian/pool/main/y/yarn/yarn_1.9.0-20180719.1538_all.deb && \
    apt-get install ./yarn_1.9.0-20180719.1538_all.deb

ENV APP_DIR /app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR

COPY . $APP_DIR

RUN gem install bundler
RUN bundle install -j4

RUN bundle exec rake assets:precompile RAILS_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
