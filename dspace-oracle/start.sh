#!/bin/bash
echo "Starting DSpace Oracle database..."

RUNNING=$(docker ps -a | grep "dspace-oracle")
echo $RUNNING

if [ -n "$RUNNING" ]; then
    docker start dspace-oracle
    echo "Started already existing database"
  else
    docker run -d -p 1521:1521 --name dspace-oracle atmire/dspace-oracle:11g2
    echo "Created new database"
fi
