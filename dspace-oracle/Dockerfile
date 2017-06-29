FROM sath89/oracle-xe-11g

MAINTAINER Atmire NV <info@atmire.com>

ENV DSPACE_DB_USER dspace
ENV DSPACE_DB_USER_PASSWORD dspace

COPY sql-scripts /tmp/scripts
COPY initialize-dspace-database.sh /tmp/initialize-dspace-database.sh

RUN chmod +x /tmp/initialize-dspace-database.sh

CMD /tmp/initialize-dspace-database.sh
