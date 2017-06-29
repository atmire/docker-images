# DSpace Oracle Database Server

## Introduction
With this image, you can start a DSpace Oracle database server. The Oracle database version used is "Oracle Express Edition 11g Release 2". You need to [install docker](https://docs.docker.com/manuals/) if you want to use this image. Docker is available for Linux, Mac and Windows.

THIS IMAGE SHOULD ONLY BE USED FOR DEVELOPMENT AND TESTING PURPOSES.

## Usage

### 1. Starting the Oracle database server
To start the database server, run the following command:

    $ docker run -d -p 1521:1521 -v /tmp/dspace-oracle-data:/u01/app/oracle --name dspace-oracle atmire/dspace-oracle:11g2

The database will store its data under `/tmp/dspace-oracle-data` on your local machine. You can change this path if you want.

#### [OPTIONAL] Importing database dump .dmp or .sql files
If you want to import an Oracle .dmp or .sql files located at `/tmp/dspace-oracle-import` when the server starts up, start the docker container as follows:

    $ docker run -d -p 1521:1521 -v /tmp/dspace-oracle-data:/u01/app/oracle -v /tmp/dspace-oracle-import:/docker-entrypoint-initdb.d --name dspace-oracle atmire/dspace-oracle:11g2

#### [OPTIONAL] Specifying Database User and Password
You can override the default database user and password by staring the container with environment variables `DSPACE_DB_USER` and `DSPACE_DB_USER_PASSWORD`:

    $ docker run -d -p 1521:1521 -v /tmp/dspace-oracle:/u01/app/oracle -e DSPACE_DB_USER=mydatabase -e DSPACE_DB_USER_PASSWORD=test1234 --name dspace-oracle atmire/dspace-oracle

This will also set the database schema to "mydatabase". The database name cannot be changed.

### 2. Check the logs of the database
Run the following command to see the output of the database startup process:

    $ docker logs dspace-oracle

You can connect to the database once you see the message "Database ready to use. Enjoy! ;)".

### 2. Stopping the database server

    $ docker stop dspace-oracle

To start the same Oracle database instance again, run

    $ docker start dspace-oracle

### 3. Removing the database server completely
First make sure the database server is stopped, then run

    $ docker rm dspace-oracle
    $ rm -rf /tmp/dspace-oracle-data

## Configure the DSpace database connection
Once the Oracle server is running, you have to configure DSpace to connect with it. Update your DSpace configuration as follows:

```
        db.dialect = org.hibernate.dialect.Oracle10gDialect
        db.schema = dspace
        db.name = oracle
        db.driver = oracle.jdbc.OracleDriver
        db.url = jdbc:oracle:thin:@//localhost:1521/XE
        db.username = dspace
        db.password = dspace
```

## Building and running locally with the utility scripts

If you've checked out this repository locally, you can build and run this docker image as follows:

1. First you need to build the image with the command:

    $ ./build.sh

2. Then you can start the database:

    $ ./start.sh

3. When you are done, you can stop the database with:

    $ ./stop.sh

4. If you don't want to keep the database, or want to start with a new empty databse, run:

    $ ./drop.sh

5. You can open the Oracle Application Express web management console by running:

    $ ./web-console.sh
