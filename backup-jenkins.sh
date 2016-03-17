#!/bin/sh

# to add in /etc/crontab
# 25 5    * * *   root  bash /etc/cron.daily/backup-jenkins.sh

# backup to remote
sshpass -p "my_password"\
 rsync -av\
 --log-file="/jenkins-backups/log/rsync.log.$(date +%Y%m%d%H%M)"\
 /jenkins-backups/backups/*\
 rsync@192.168.1.1::project/jenkins-backups/


# delete old backups/logs = 10
find /jenkins-backups/log/* -mtime +9 -exec rm {} \;
