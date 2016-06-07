#!/bin/bash

wget https://raw.githubusercontent.com/ivantichy/jira-docker/7.1.7/runjira.sh -O ~/runjira.sh && chmod +x ~/runjira.sh
~/runjira.sh

docker run -d -h dropbox --name dropbox -v /var/docker-data/Dropbox/config:/root/.dropbox -v /var/docker-data/Dropbox/zaloha:/root/Dropbox -v /var/docker-data/:/var/docker-data/ -v /etc/localtime:/etc/localtime:ro ivantichy/kon-dropbox-backup

docker run --name tor -p 6000-6001:6000-6001 -d ivantichy/tor

docker run -p 8082:8080 -p 50000:50000 -d -v /var/docker-data/jenkins-home:/var/jenkins_home ivantichy/kon-jenkins



