#!/bin/bash


if [ "$1" == "" ]; then
 exit 1
fi

if [ "`docker ps | grep $1 -c`" == "0" ]; then
 exit 2
fi




docker stop `docker ps | grep $1 | cut -d " " -f1`








