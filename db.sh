#!/bin/bash


if [ "$1" == "" ]; then
echo "empy parameter"
exit 1
fi


docker exec -it --user 0 `docker ps | grep $1 | cut -d " " -f1` bash

