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

DIR=reporting-$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p $DIR

cp ./start.sh $DIR/start.sh
cp -r ./configs $DIR/configs
cp -r ./hosts $DIR/hosts
cp ./configuration-versions.sh $DIR/configuration-versions.sh

docker logs nginx &> $DIR/log-nginx.out
docker logs memcached &> $DIR/log-memcached.out
docker logs mongodb &> $DIR/log-mongodb.out
docker logs postgresql &> $DIR/log-postgresql.out
docker logs iipCyto &> $DIR/log-iipCyto.out
if [[ "$(docker ps -q -f name=rabbitmq)" ]]; then docker logs rabbitmq &> $DIR/log-rabbitmq.out; fi
if [[ "$(docker ps -q -f name=backup_mongo)" ]]; then docker logs backup_mongo &> $DIR/log-backup_mongo.out; fi
if [[ "$(docker ps -q -f name=backup_postgis)" ]]; then docker logs backup_postgis &> $DIR/log-backup_postgis.out; fi
if [[ "$(docker ps -q -f name=retrieval)" ]]; then docker logs retrieval &> $DIR/log-retrieval.out; fi
if [[ "$(docker ps -q -f name=iipJP2)" ]]; then docker logs iipJP2 &> $DIR/log-iipJP2.out; fi
if [[ "$(docker ps -q -f name=bioformat)" ]]; then docker logs bioformat &> $DIR/log-bioformat.out; fi
if [[ "$(docker ps -q -f name=ims)" ]]; then docker logs ims &> $DIR/log-ims.out; fi
if [[ "$(docker ps -q -f name=core)" ]]; then docker logs core &> $DIR/log-core.out; fi
if [[ "$(docker ps -q -f name=iris)" ]]; then docker logs iris &> $DIR/log-iris.out; fi
if [[ "$(docker ps -q -f name=software_router)" ]]; then docker logs software_router &> $DIR/log-software_router.out; fi
if [[ "$(docker ps -q -f name=slurm)" ]]; then docker logs slurm &> $DIR/log-slurm.out; fi

tar -zcvf $DIR.tar.gz $DIR
rm -r $DIR
