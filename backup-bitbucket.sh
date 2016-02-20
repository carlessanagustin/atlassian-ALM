#!/bin/bash

java \
-Dbitbucket.password="bitbucket_password" \
-Dbitbucket.user="bitbucket_user" \
-Dbitbucket.baseUrl="http://localhost:7990" \
-Dbitbucket.home=/var/atlassian/application-data/bitbucket \
-Dbackup.home=/bitbucket-backups \
-jar /opt/atlassian/bitbucket-backup-client-2.0.2/bitbucket-backup-client.jar
