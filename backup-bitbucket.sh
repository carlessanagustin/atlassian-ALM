#!/bin/bash

# backup to local
java \
-Dbitbucket.password="bitbucket_password" \
-Dbitbucket.user="bitbucket_user" \
-Dbitbucket.baseUrl="http://localhost:7990" \
-Dbitbucket.home=/var/atlassian/application-data/bitbucket \
-Dbackup.home=/bitbucket-backups \
-jar /opt/atlassian/bitbucket-backup-client-2.0.2/bitbucket-backup-client.jar


# backup to remote
rsync -av\
 --log-file="/bitbucket-backups/log/rsync.log.$(date +%Y%m%d%H%M)"\
 /bitbucket-backups/backups/*\
 rsync@192.168.1.1::project/bitbucket-backups/
