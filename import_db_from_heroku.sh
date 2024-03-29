#!/bin/bash

echo "[1/4] Capturing backup on Heroku"
heroku pg:backups:capture --app mlabs-parking-manager

echo "[2/4] Downloading backup"
heroku pg:backups:download --app mlabs-parking-manager

echo "[3/4] Mounting backup on local database"
docker-compose run --rm web pg_restore --verbose --clean --no-acl --no-owner \
 -h db -U postgres -d app_development latest.dump

echo "[4/4] Removing local backup"
rm latest.dump
