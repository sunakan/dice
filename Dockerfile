FROM ruby:2.6.1-alpine3.9

WORKDIR /app
COPY Gemfile* ./

# nokogiriのために g++,make,libxml2-dev,libxslt-dev 入れたら、他のも全部入った
# yarnはalpine3.6+からapkで入る!! nodejsとかもこれで入る
# tzdataはprecopile時にTZInfo::ZoneinfoDirectoryNotFoundとか言われたので、入れる
RUN apk update && \
  apk add --update --no-cache --virtual .build-depends g++ make libxml2-dev libxslt-dev && \
  apk add --update --no-cache yarn tzdata && \
  gem install bundler -N && \
  bundle install && \
  apk del --purge .build-depends

COPY . ./

# yarn install
# precopile
RUN yarn install && \
  bundle exec rake assets:precompile RAILS_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
