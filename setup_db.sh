#!/bin/bash

echo "Setup DB"
echo "====================rake db:create"
sudo docker-compose exec app bundle exec rake db:create
echo "====================ridgepole -c config/database.yml -E development --apply -f db/Schemafile"
sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
echo "====================ridgepole -c config/database.yml -E test --apply -f db/Schemafile"
sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile
echo "====================rake ext_db:create"
sudo docker-compose exec app bundle exec rake ext_db:create
echo "====================rake ext_db:ridgepole:apply"
sudo docker-compose exec app bundle exec rake ext_db:ridgepole:apply
