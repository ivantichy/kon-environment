#!/bin/bash

docker ps -aq | xargs docker rm
docker images -q | xargs docker rmi
docker volume ls -q | xargs docker volume rm

