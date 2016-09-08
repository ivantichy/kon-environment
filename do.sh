#!/bin/bash

workdir=`pwd`
installdir=`echo ~`

function getfromgit {
  echo $1
  mkdir -p $installdir/$1
  cd $installdir/$1
  git init
  git remote add origin git@github.com:ivantichy/$1-docker.git 2> /dev/null
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
  $workdir/ds.sh $1
  docker rm $1 2>/dev/null
}

stopit jira
stopit kon-test-proxy
stopit tor
stopit kon-dropbox-backup
stopit kon-jenkins
stopit exim

getfromgit jira
getfromgit kon-test-proxy
getfromgit tor
getfromgit kon-dropbox-backup
getfromgit kon-jenkins
getfromgit exim

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
buildit exim

./jenkins-socat.sh

runit jira
runit kon-test-proxy
runit tor
runit kon-dropbox-backup
runit jenkins
runit exim

$workdir/dc.sh 2> /dev/null




