# Algebrist Search
The basic idea is that there are three docker containers which need to be running. Elasticsearch (and its password needs to be in the ELASTIC_PASSWORD enviromental variable), the sist2 webserver, and the sist2 updater. There are docker compose and docker files for each. To rebuild from scratch follow these steps

## Elasticsearch
Follow the steps laied out in https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
However, if that link has died they are also here

```bash
cd elasticsearch 

docker network create elastic

docker-compose up -d

docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```
copy the output of the final command and put it in the ELASTIC_PASSWORD enviromental variable. 

There is now an elasticsearch container running at https://localhost:9200. Note that the cert in the container (which you can copy with the command docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt . is self signed and therefore may be untrusted. Use --insecure on curl or the --es-insecure flag on sist to ignore this). Moreover, the elasticsearch data is stored at the mount point in the docker compose file (currently set to a location on my zfs pool so that too much space is not consumed on my boot drive. This is not ideal as it is slow 
and a better solution would be to put it on an ssd). Also the elasticsearch container has a 1g mem limit. It may make sense to increase this to 2, 3, or 4g as I have been running into some issues with a 1g limit.

Next resource the shell so that ELASTIC_PASSWORD is in the current enviromental and run the following (assuming you are still in the elasticsearch subdirectory move back up to the root directory first)

```bash
cd sistupdate
docker build -t sist2updater:0.1 .
docker-compose up -d
```

This will start a docker container which runs an update script every day at midnight. Updates are done incramentally so only the first one should take multiple days (depending on the size being indexed.) This is all done for my server and paths are specific too it (indexes are done on the folders Thomas, Documents, Transfer, WDTransfer, Videos, Pictures, Music, and Astronomy all of which are subdirectories of /mnt/p/d/ which is mounted as a volumme from the host to the same dir in the docker container generated)

Finally, to start the webserver move back to the root directory and run the followiing

```bash
cd webserver
docker build -t sist2webserver:0.5 . 
docker-compose up -d
```

A sist2 webserver is now running bound to 0.0.0.0:4090. Make sure to secure this behind an authenticaion layer if exposing it to the internet. I currently have it running behind authentik. The webserver should auto update whenever the database updates. However, it is also setup to automatically restart everyday at 5 am (thoretically this should be enough time for the update script to have finished running most time)
