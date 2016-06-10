#!/bin/bash

workdir=`pwd`
installdir=`echo ~`

function getfromgit {
  echo $1
  mkdir -p $installdir/$1
  cd $installdir/$1
  git init
  git remote add origin https://github.com/ivantichy/$1.git
  git pull origin master
}

function getfromdockerhub {
  docker pull ivantichy/$1
}

function buildit {
  cd $installdir/$1
  ./build.sh
}

function runit {
  cd $installdir/$1
  ./run.sh &
}

function stopit {
  $workdir/ds $1
}

stopit jira
stopit kon-test-proxy
stopit tor
stopit kon-dropbox-backup
stopit jenkins

getfromgit jira-docker
getfromgit kon-test-proxy-docker
getfromgit tor
getfromgit kon-dropbox-backup-docker
getfromgit jenkins-docker


exit

#getfromdockerhub jira
#getfromdockerhub kon-test-proxy
#getfromdockerhub tor
#getfromdockerhub kon-dropbox-backup
#getfromdockerhub jenkins

buildit jira
buildit kon-test-proxy
buildit tor
buildit kon-dropbox-backup
buildit jenkins

runit jira-docker
runit kon-test-proxy-docker
runit tor
runit kon-dropbox-backup-docker
runit jenkins-docker



