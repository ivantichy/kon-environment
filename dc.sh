#!/bin/bash

docker ps -aq | xargs docker rm 2> /dev/null
docker images -q | xargs docker rmi 2> /dev/null
docker volume ls -q | xargs docker volume rm 2> /dev/null



