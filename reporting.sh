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

. ./configuration.sh

DIR=reporting-$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p $DIR

cp ./start.sh $DIR/start.sh
cp -r ./configs $DIR/configs
cp -r ./hosts $DIR/hosts
cp ./configuration-versions.sh $DIR/configuration-versions.sh

docker logs ${INSTANCE_PREFIX}nginx &> $DIR/log-nginx.out
docker logs ${INSTANCE_PREFIX}mongodb &> $DIR/log-mongodb.out
docker logs ${INSTANCE_PREFIX}postgresql &> $DIR/log-postgresql.out
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}rabbitmq)" ]]; then docker logs ${INSTANCE_PREFIX}rabbitmq &> $DIR/log-rabbitmq.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}backup_mongo)" ]]; then docker logs ${INSTANCE_PREFIX}backup_mongo &> $DIR/log-backup_mongo.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}backup_postgis)" ]]; then docker logs ${INSTANCE_PREFIX}backup_postgis &> $DIR/log-backup_postgis.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}retrieval)" ]]; then docker logs ${INSTANCE_PREFIX}retrieval &> $DIR/log-retrieval.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}bioformat)" ]]; then docker logs ${INSTANCE_PREFIX}bioformat &> $DIR/log-bioformat.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}ims)" ]]; then docker logs ${INSTANCE_PREFIX}ims &> $DIR/log-ims.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}ims-worker)" ]]; then docker logs ${INSTANCE_PREFIX}ims-worker &> $DIR/log-ims-worker.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}pims-cache)" ]]; then docker logs ${INSTANCE_PREFIX}pims-cache &> $DIR/log-pims-cache.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}hms)" ]]; then docker logs ${INSTANCE_PREFIX}hms &> $DIR/log-hms.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}core)" ]]; then docker logs ${INSTANCE_PREFIX}core &> $DIR/log-core.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}iris)" ]]; then docker logs ${INSTANCE_PREFIX}iris &> $DIR/log-iris.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}software_router)" ]]; then docker logs ${INSTANCE_PREFIX}software_router &> $DIR/log-software_router.out; fi
if [[ "$(docker ps -q -f name=${INSTANCE_PREFIX}slurm)" ]]; then docker logs ${INSTANCE_PREFIX}slurm &> $DIR/log-slurm.out; fi
${INSTANCE_PREFIX}
tar -zcvf $DIR.tar.gz $DIR
rm -r $DIR
