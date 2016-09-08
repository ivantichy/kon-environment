#!/bin/bash

killall socat
rm -rf /var/docker-data/jenkins-home/docker.sock
nohup socat "UNIX-LISTEN:/var/docker-data/jenkins-home/docker.sock,reuseaddr,fork" "UNIX-CONNECT:/var/run/docker.sock" > foo.out 2> foo.err < /dev/null &
sleep 5
chown jenkins:jenkins /var/docker-data/jenkins-home/docker.sock


