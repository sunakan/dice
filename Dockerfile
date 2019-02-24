# NOTE
# nokogiriのために g++,make,libxml2-dev,libxslt-dev 入れたら、他のも全部入った
# mysql2のためにmariadb-connector-c-dev
# yarnはalpine3.6+からapkで入る!! nodejsとかもこれで入る
# tzdataはprecopile時にTZInfo::ZoneinfoDirectoryNotFoundとか言われたので、入れる
# rm -rfキャッシュ系の削除(bundlerは--no-cacheオプションでも消えないバグがあるため、手動)
# dockerizeはDockerのコンテナの起動を待つためのもの

FROM ruby:2.6.1-alpine3.9 as builder
WORKDIR /app
COPY Gemfile* ./
RUN apk update && \
  apk add --no-cache --virtual .build-depends g++ make libxml2-dev libxslt-dev&& \
  apk add --no-cache yarn tzdata mariadb-connector-c-dev && \
  gem install bundler -N && \
  bundle install --no-cache -j4 --path=vendor/bundle

ENV DOCKERIZE_VERSION v0.6.1
RUN apk update && \
  apk add --no-cache openssl && \
  wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

FROM ruby:2.6.1-alpine3.9 as production
WORKDIR /app
COPY Gemfile* ./
COPY --from=builder /app/vendor/bundle /app/vendor/bundle
RUN apk update && \
  apk add --no-cache yarn tzdata mariadb-connector-c-dev && \
  gem install bundler -N && \
  bundle install --no-cache -j4 --path=vendor/bundle --without development test && \
  bundle clean && \
  rm -rf /usr/local/lib/ruby/gems/2.6.0/cache && \
  rm -rf /root/.bundle/cache/compact_index/* && \
  rm -rf /var/cache/* && \
  rm -rf /usr/local/bundle/cache && \
  rm -rf vendor/bundle/ruby/2.6.0/cache
COPY . ./
RUN yarn install && \
   RAILS_ENV=production bundle exec rake assets:precompile
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
