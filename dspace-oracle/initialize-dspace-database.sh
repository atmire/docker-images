#!/bin/bash

#First start Oracle Database Server
echo "Starting database"
/entrypoint.sh &

sleep 5s

echo "Starting database initialization"

. /etc/profile

echo "select count(*) from dba_users;" > /tmp/test.sql
echo "EXIT;" >> /tmp/test.sql

RUNNING=$(sqlplus -L system/oracle @/tmp/test.sql | grep "Connected to")

echo $RUNNING

while [ ! -n "$RUNNING" ]
do
  echo "Waiting for database to have started completely..."
  sleep 2s

  STATUS=$(sqlplus -L system/oracle @/tmp/test.sql)
  RUNNING=$( echo "$STATUS" | grep "Connected to")
done

echo "Executing scripts in /tmp/scripts"
for f in /tmp/scripts/*.sql
do
 echo "Processing $f"

 sed -i.bak \
      -e "s/\${DSPACE_DB_USER}/$DSPACE_DB_USER/g" \
      -e "s/\${DSPACE_DB_USER_PASSWORD}/$DSPACE_DB_USER_PASSWORD/g" \
      "$f"

  sqlplus -L system/oracle @"$f" > /dev/null
done

echo "Scripts executed"
echo "Database initialized"

tail -f /u01/app/oracle/diag/rdbms/xe/XE/trace/alert_XE.log
