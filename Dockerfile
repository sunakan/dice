# NOTE
# nokogiriのために g++,make,libxml2-dev,libxslt-dev 入れたら、他のも全部入った
# yarnはalpine3.6+からapkで入る!! nodejsとかもこれで入る
# tzdataはprecopile時にTZInfo::ZoneinfoDirectoryNotFoundとか言われたので、入れる
# rm -rfキャッシュ系の削除(bundlerは--no-cacheオプションでも消えないバグがあるため、手動)

FROM ruby:2.6.1-alpine3.9 as builder
WORKDIR /app
COPY Gemfile* ./
RUN apk update && \
  apk add --no-cache --virtual .build-depends g++ make libxml2-dev libxslt-dev && \
  apk add --no-cache yarn tzdata && \
  gem install bundler -N && \
  bundle install --no-cache -j4 --path=vendor/bundle

FROM ruby:2.6.1-alpine3.9 as production
WORKDIR /app
COPY Gemfile* ./
COPY --from=builder /app/vendor/bundle /app/vendor/bundle
RUN apk update && \
  apk add --no-cache yarn tzdata && \
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
