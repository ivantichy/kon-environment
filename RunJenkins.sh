#!/bin/bash

docker run -p 8080:8080 -p 50000:50000 -v /var/docker-data/jenkins-home:/var/jenkins_home ivantichy/kon-jenkins



