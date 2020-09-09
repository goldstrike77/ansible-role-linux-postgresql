#!/bin/sh

DATE=/bin/date
CAT=/bin/cat
FORMAIL=/bin/formail
SENDMAIL=/sbin/sendmail
BACKUPEX=/bin/pgbackrest
RCLONE=/bin/rclone
TMPFILE="/tmp/pgBackRest.$$.log"
MAILTO={{ pgsql_mailto }}

if [ "`$DATE +%w`" == "0" ]; 
then
   $BACKUPEX --type=full --stanza=database --log-level-console=info backup > $TMPFILE 2>&1
else
   $BACKUPEX --type=incr --stanza=database --log-level-console=info backup > $TMPFILE 2>&1
fi

if [ -z "`tail -1 $TMPFILE | grep 'completed successfully'`" ] ; then
  echo "Backup failed:"; echo
  $CAT $TMPFILE | $FORMAIL -I "X-Message-Flag: " -I "X-Priority: 1 (Highest)" -I "Importance: high" -I "X-MSMail-Priority: High" -I "From: do-not-reply@somebody.com" -I "Subject:"`hostname`" PostgreSQL backup failed on "`date '+%Y%m%d'` | $SENDMAIL -oi $MAILTO
  exit 1
else
  $CAT $TMPFILE | $FORMAIL -I "From: do-not-reply@somebody.com" -I "Subject:"`hostname`" PostgreSQL backup succeed on "`date '+%Y%m%d'` | $SENDMAIL -oi $MAILTO
fi

{% if pgsql_backupset_arg.cloud_rsync | bool and pgsql_backupset_arg.cloud_drive is defined %}
# Rsync for cloud storage
$RCLONE --no-check-certificate --verbose --config="/etc/rclone/pgsql.conf" mkdir pgsql:{{ ansible_hostname | lower }}
$RCLONE --no-check-certificate --bwlimit="{{ pgsql_backupset_arg.cloud_bwlimit | default('10M') }}" --verbose --config="/etc/rclone/pgsql.conf" {{ consul_backupset_arg.cloud_event | default('sync') }} {{ pgsql_path }}/backup/pgsql/backup pgsql:{{ ansible_hostname | lower }}/pgsql
{% endif %}
# Cleanup
#rm -f $TMPFILE
exit 0
