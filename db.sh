#!/bin/bash


if [ "$1" == "" ]; then
echo "dnf"
exit 1
fi


docker exec -it `docker ps | grep $1 | cut -d " " -f1` bash

