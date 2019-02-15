FROM ruby:2.6.1-alpine3.9

WORKDIR /app
COPY Gemfile* ./

# nokogiriのために g++,make,libxml2-dev,libxslt-dev 入れたら、他のも全部入った
# yarnはalpine3.6+からapkで入る!! nodejsとかもこれで入る
# tzdataはprecopile時にTZInfo::ZoneinfoDirectoryNotFoundとか言われたので、入れる
# rm -rfキャッシュ系の削除(bundlerは--no-cacheオプションでも消えないバグがあるため、手動)
RUN apk update && \
  apk add --no-cache --virtual .build-depends g++ make libxml2-dev libxslt-dev && \
  apk add --no-cache yarn tzdata && \
  gem install bundler -N && \
  bundle install --no-cache -j4 && \
  apk del --purge .build-depends && \
  rm -rf /usr/local/lib/ruby/gems/2.6.0/cache && \
  rm -rf /root/.bundle/cache/compact_index/* && \
  rm -rf /var/cache/* && \
  rm -rf /usr/local/bundle/cache

COPY . ./

# yarn install
# precopile
RUN yarn install && \
  bundle exec rake assets:precompile RAILS_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
