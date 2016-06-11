#!/bin/bash


if [ "$1" == "" ]; then
  echo "missing paramater"
  exit 1
fi

if [ "`docker ps | grep $1 -c`" == "0" ]; then
  echo "did not find container like this"
  exit 2
fi



echo "stopping"
docker stop `docker ps | grep $1 | cut -d " " -f1`
echo "stopped"








