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

echo "Stopping Cytomine... Data will be preserved in databases."

docker stop memcached
docker rm -v memcached

if [[ "$(docker ps -q -f name=rabbitmq)" ]]
then
    docker stop rabbitmq
    docker rm -v rabbitmq
fi

docker stop mongodb
docker rm -v mongodb
docker stop postgresql
docker rm -v postgresql

if [[ "$(docker ps -q -f name=backup_mongo)" ]]
then
    docker stop backup_mongo
    docker rm -v backup_mongo
fi

if [[ "$(docker ps -q -f name=backup_postgis)" ]]
then
    docker stop backup_postgis
    docker rm -v backup_postgis
fi

if [[ "$(docker ps -q -f name=retrieval)" ]]
then
    docker stop retrieval
    docker rm -v retrieval
fi

if [[ "$(docker ps -q -f name=iipJP2)" ]]
then
    docker stop iipJP2
    docker rm -v iipJP2
fi

docker stop iipCyto
docker rm -v iipCyto

if [[ "$(docker ps -q -f name=bioformat)" ]]
then
    docker stop bioformat
    docker rm -v bioformat
fi

if [[ "$(docker ps -q -f name=ims)" ]]
then
    docker stop ims
    docker rm -v ims
fi

if [[ "$(docker ps -q -f name=core)" ]]
then
    docker stop core
    docker rm -v core
fi

if [[ "$(docker ps -q -f name=iris)" ]]
then
    docker stop iris
    docker rm -v iris
fi

docker stop nginx
docker rm -v nginx

if [[ "$(docker ps -q -f name=software_router)" ]]
then
    docker stop software_router
    docker rm -v software_router
fi

if [[ "$(docker ps -q -f name=slurm)" ]]
then
    docker stop slurm
    docker rm -v slurm
fi

echo "Done."
