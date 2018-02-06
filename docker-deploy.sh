#!/bin/bash

export DOCKER_HOST="tcp://127.0.0.1:2375"

docker-compose stop

names=(personal-accounting-application:0.0.1 
personal-accounting-config-server:0.0.1 
personal-accounting-gateway:0.0.1 
personal-accounting-taxcaculator:0.0.1 
personal-accounting-discovery:0.0.1 
personal-accounting-discovery:0.0.1)

for index in "${!names[@]}"; do
 echo $(docker stop $(docker ps -a -q -f ancestor=${names[$index]}))
 echo $(docker rm   $(docker ps -a -q -f ancestor=${names[$index]}))
done

echo $(docker rmi $(docker images --filter "dangling=true" -q --no-trunc))

docker-compose up -d