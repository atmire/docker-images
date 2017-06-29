#!/bin/bash
echo "Dropping DSpace Oracle database..."
docker stop dspace-oracle
docker rm dspace-oracle
