FROM eu.gcr.io/halfpipe-io/jsd/dbt_all:v1.9.4

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
