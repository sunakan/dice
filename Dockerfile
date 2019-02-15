FROM ruby:2.6.1-alpine3.9

# nokogiriのために g++,make,libxml2-dev,libxslt-dev 入れたら、他のも全部入った
# yarnはalpine3.6+からapkで入る!!
# tzdataはprecopile時にTZInfo::ZoneinfoDirectoryNotFoundとか言われたので、入れる
RUN apk update && \
  apk add --update --no-cache --virtual .build-depends \
  g++ make libxml2-dev libxslt-dev \
  yarn \
  tzdata

WORKDIR /app
RUN gem install bundler -N
COPY Gemfile* ./
RUN bundle install

COPY . ./

# yarn install
RUN yarn install

# precopile
RUN bundle exec rake assets:precompile RAILS_ENV=production

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
