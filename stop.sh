#!/bin/bash

# Copyright (c) 2009-2018. Authors: see NOTICE file.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. configuration.sh

echo "Stopping Cytomine... Data will be preserved in databases."

docker stop ${INSTANCE_PREFIX}memcached
docker rm -v ${INSTANCE_PREFIX}memcached

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}rabbitmq)" ]]
then
    docker stop ${INSTANCE_PREFIX}rabbitmq
    docker rm -v ${INSTANCE_PREFIX}rabbitmq
fi

docker stop ${INSTANCE_PREFIX}mongodb
docker rm -v ${INSTANCE_PREFIX}mongodb
docker stop ${INSTANCE_PREFIX}postgresql
docker rm -v ${INSTANCE_PREFIX}postgresql

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}backup_mongo)" ]]
then
    docker stop ${INSTANCE_PREFIX}backup_mongo
    docker rm -v ${INSTANCE_PREFIX}backup_mongo
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}backup_postgis)" ]]
then
    docker stop ${INSTANCE_PREFIX}backup_postgis
    docker rm -v ${INSTANCE_PREFIX}backup_postgis
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}retrieval)" ]]
then
    docker stop ${INSTANCE_PREFIX}retrieval
    docker rm -v ${INSTANCE_PREFIX}retrieval
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}iipJP2)" ]]
then
    docker stop ${INSTANCE_PREFIX}iipJP2
    docker rm -v ${INSTANCE_PREFIX}iipJP2
fi

docker stop ${INSTANCE_PREFIX}iipCyto
docker rm -v ${INSTANCE_PREFIX}iipCyto

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}bioformat)" ]]
then
    docker stop ${INSTANCE_PREFIX}bioformat
    docker rm -v ${INSTANCE_PREFIX}bioformat
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}ims)" ]]
then
    docker stop ${INSTANCE_PREFIX}ims
    docker rm -v ${INSTANCE_PREFIX}ims
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}core)" ]]
then
    docker stop ${INSTANCE_PREFIX}core
    docker rm -v ${INSTANCE_PREFIX}core
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}webUI)" ]]
then
    docker stop ${INSTANCE_PREFIX}webUI
    docker rm -v ${INSTANCE_PREFIX}webUI
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}iris)" ]]
then
    docker stop ${INSTANCE_PREFIX}iris
    docker rm -v ${INSTANCE_PREFIX}iris
fi

docker stop ${INSTANCE_PREFIX}nginx
docker rm -v ${INSTANCE_PREFIX}nginx

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}software_router)" ]]
then
    docker stop ${INSTANCE_PREFIX}software_router
    docker rm -v ${INSTANCE_PREFIX}software_router
fi

if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}slurm)" ]]
then
    docker stop ${INSTANCE_PREFIX}slurm
    docker rm -v ${INSTANCE_PREFIX}slurm
fi

echo "Done."
