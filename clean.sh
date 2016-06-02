#!/bin/bash

docker ps -aq | xargs docker rm -f
docker images -q | xargs docker rmi -f
docker volume ls -q | xargs docker volume rm

