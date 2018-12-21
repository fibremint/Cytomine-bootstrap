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

FILES=(configs/core/cytomineconfig.groovy configs/ims/imageserverconfig.properties configs/iipCyto/nginx.conf.sample configs/iipCyto/iip-configuration.sh configs/iipJP2/nginx.conf.sample configs/iris/iris-config.groovy configs/iris/iris-production-config.groovy configs/nginx/nginx.conf configs/nginx/nginxDevCore.conf configs/nginx/nginxDevIMS.conf configs/software_router/config.groovy start_deploy.sh dev_core_start_deploy.sh hosts/core/addHosts.sh hosts/ims/addHosts.sh hosts/retrieval/addHosts.sh hosts/iris/addHosts.sh hosts/software_router/addHosts.sh hosts/slurm/addHosts.sh)

#get all the config values.
. ./configuration.sh
. ./versions.sh
. ./keys.sh


VARIABLES=()
while read LINE; do
    if [[ $LINE == *"="* ]]; then
        IFS='=' read -ra ADDR <<< "$LINE"
        VARIABLES+=(${ADDR[0]})
    fi
done <<< "$(cat configuration.sh)"

while read LINE; do
    if [[ $LINE == *"="* ]]; then
        IFS='=' read -ra ADDR <<< "$LINE"
        VARIABLES+=(${ADDR[0]})
    fi
done  <<< "$(cat versions.sh)"

VARIABLES=("${VARIABLES[@]}" "${KEYS[@]}")

for i in ${FILES[@]}; do
    if [[ -f "$i.sample" ]]; then
        cp $i.sample $i
        for j in ${VARIABLES[@]}; do
            if [[ $j != *"IRIS_ADMIN"*"NAME"* ]]; then
                if [[ "$OSTYPE" == "linux-gnu" ]]; then
                    eval sed -i "s~\\\$$j~\$$j~g" $i
                elif [[ "$OSTYPE" == "darwin"* ]]; then
                    eval sed -i '' -e "s~\\\$$j~\$$j~g" $i && rm $i-e
                fi
            fi
        done

        ##spaces into these variables
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            sed -i "s~\$IRIS_ADMIN_NAME~$IRIS_ADMIN_NAME~g" $i
            sed -i "s~\$IRIS_ADMIN_ORGANIZATION_NAME~$IRIS_ADMIN_ORGANIZATION_NAME~g" $i
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' -e "s~\$IRIS_ADMIN_NAME~$IRIS_ADMIN_NAME~g" $i
            sed -i '' -e "s~\$IRIS_ADMIN_ORGANIZATION_NAME~$IRIS_ADMIN_ORGANIZATION_NAME~g" $i
        fi
    fi
done
