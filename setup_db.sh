#!/bin/bash

echo "Setup DB"
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
sudo docker-compose exec app bundle exec rake ext_db:ridgepole:apply
