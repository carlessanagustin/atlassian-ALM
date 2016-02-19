#!/bin/bash

SRCDIR=/var/atlassian/application-data/bitbucket/log
DESDIR=/bitbucket-backups

TIME=`date +%b-%d-%y`
FILENAME=backup_logs-$TIME.tar.gz

sudo -u atlbitbucket tar -cpzf $DESDIR/$FILENAME $SRCDIR
