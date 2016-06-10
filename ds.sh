#!/bin/bash


if [ "$1" == "" ]; then
exit 1
fi


docker stop `docker ps | grep $1 | cut -d " " -f1`








