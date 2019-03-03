#!/bin/bash

echo "Setup DB"
echo "====================Waiting DB"
sudo docker-compose exec app dockerize -wait tcp://mariadb:3306 -timeout 1m
echo "====================rake db:create"
sudo docker-compose exec app bundle exec rake db:create
echo "====================ridgepole -c config/database.yml -E development --apply -f db/Schemafile"
sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
echo "====================ridgepole -c config/database.yml -E test --apply -f db/Schemafile"
sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile
echo "====================rake ext_db:create RAILS_ENV=development"
sudo docker-compose exec app bundle exec rake ext_db:create RAILS_ENV=development
echo "====================rake ext_db:create RAILS_ENV=test"
sudo docker-compose exec app bundle exec rake ext_db:create RAILS_ENV=test
echo "====================rake ext_db:ridgepole:apply"
sudo docker-compose exec app bundle exec rake ext_db:ridgepole:apply RAILS_ENV=development
sudo docker-compose exec app bundle exec rake ext_db:ridgepole:apply RAILS_ENV=test
echo "====================rails r db/worldcup2014/seeds.rb"
sudo docker-compose exec app bundle exec rails r db/worldcup2014/seeds.rb -e development
sudo docker-compose exec app bundle exec rails r db/worldcup2014/seeds.rb -e test
