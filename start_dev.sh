#!/bin/bash
CORE_WAR_URL="http://192.168.1.8:8888/ims/ROOT.war"
IMS_WAR_URL="http://192.168.1.8:8888/core/ROOT.war"
CORE_URL=aurora_core.cytomine.be #aurora.cytomine.be
IMS_URL=aurora_ims.cytomine.be #aurora-ims.cytomine.be
IIP_URL=aurora_iip.cytomine.be #aurora-iip.cytomine.be
UPLOAD_URL=aurora_upload.cytomine.be #aurora-upload.cytomine.be
IMS_STORAGE_PATH=/opt/docker_vol
MOUNT_IMS_STORAGE_PATH=/opt/docker_vol
IMS_BUFFER_PATH=/tmp/imageserver_buffer
RABBITMQ_PASS="mypass"
MEMCACHED_PASS="mypass"

# create memcached docker
docker run -d -p 11211:11211 -e MEMCACHED_PASS="mypass" --name memcached cytomine/memcached

# create rabbitmq docker
docker run -d -p 22 -p 5672:5672 -p 15672:15672 --name rabbitmq \
-e RABBITMQ_PASS=$RABBITMQ_PASS \
cytomine/rabbitmq

# create database docker
docker run -p 22 -m 8g -d --name db cytomine/postgis

# create IMS docker
docker run -p 22 -p 81:80 -v /opt/docker_vol:/opt/docker_vol -m 1g -d --name ims --link memcached:memcached \
-e IIP_URL=$IIP_URL \
-e IMS_STORAGE_PATH=$IMS_STORAGE_PATH \
-e UPLOAD_URL=$UPLOAD_URL \
-e IMS_BUFFER_PATH=$IMS_BUFFER_PATH \
-e WAR_URL="http://192.168.1.8:8888/ims/ROOT.war" \
cytomine/ims

# create CORE docker
docker run -m 1g -d -p 22 --name core --link rabbitmq:rabbitmq --link db:db --link ims:ims \
-e CORE_URL=$CORE_URL \
-e IMS_URL=$IMS_URL \
-e IIP_URL=$IIP_URL \
-e UPLOAD_URL=$UPLOAD_URL \
-e IMS_STORAGE_PATH=$IMS_STORAGE_PATH \
-e IMS_BUFFER_PATH=$IMS_BUFFER_PATH \
-e WAR_URL="http://192.168.1.8:8888/core/ROOT.war" cytomine/core

# create nginx docker
docker run -m 1g -d -p 22 -p 80:80 --link core:core --link ims:ims \
-e CORE_URL=$CORE_URL \
-e IMS_URL=$IMS_URL \
cytomine/nginx

