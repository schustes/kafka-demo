#!/bin/bash

export DOCKER_HOST="tcp://192.168.56.1:2375"

docker-compose stop

names=(kafka-demo:latest
       , spotify/kafka:latest
 )


for index in "${!names[@]}"; do
 echo $(docker stop $(docker ps -a -q -f ancestor=${names[$index]}))
 echo $(docker rm   $(docker ps -a -q -f ancestor=${names[$index]}))
done

echo $(docker rmi $(docker images --filter "dangling=true" -q --no-trunc))

docker-compose up -d