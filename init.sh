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

# Get all the config values.
. utils/files.sh
. utils/keys.sh
. configuration.sh
. configuration-versions.sh

# Fix container aliases for core/ims development
ALIASES=('POSTGRES_ALIAS' 'MONGODB_ALIAS' 'RABBITMQ_ALIAS' 'BIOFORMAT_ALIAS')
POSTGRES_ALIAS=postgresql
MONGODB_ALIAS=mongodb
RABBITMQ_ALIAS=rabbitmq
BIOFORMAT_ALIAS=bioformat
if [[ $CORE_DEVELOPMENT = true ]]; then
    POSTGRES_ALIAS=localhost
    MONGODB_ALIAS=localhost
    RABBITMQ_ALIAS=localhost
fi
if [[ $IMS_DEVELOPMENT = true ]]; then
    BIOFORMAT_ALIAS=localhost
fi

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
done  <<< "$(cat configuration-versions.sh)"

VARIABLES=("${VARIABLES[@]}" "${KEYS[@]}")
VARIABLES=("${VARIABLES[@]}" "${ALIASES[@]}")

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
            if [[ $IRIS_ENABLED = false ]]; then sed -i "/--link iris:iris/d" $i; fi
            if [[ $RETRIEVAL_ENABLED = false ]]; then sed -i "/--link retrieval:retrieval/d" $i; fi
            if [[ $BIOFORMAT_ENABLED = false ]]; then sed -i "/--link bioformat:bioformat/d" $i; fi
            if [[ $IIP_JP2_ENABLED = false ]]; then sed -i "/--link iipJP2:iipJP2/d" $i; fi
            if [[ $SOFTWARE_ENABLED = false ]]; then sed -i "/--link rabbitmq:rabbitmq/d" $i; fi
            if [[ $CORE_DEVELOPMENT = true ]]; then
                sed -i "/--link core:core/d" $i
            else
                sed -i "/-p 5672:5672 -p 15672:15672/d" $i
                sed -i "/-p 5432:5432/d" $i
                sed -i "/-p 27017:27017 -p 28017:28017/d" $i
                sed -i "/-p 10022:22/d" $i
                sed -i "/-p 22/d" $i
            fi
            if [[ $IMS_DEVELOPMENT = true ]]; then sed -i "/--link ims:ims/d" $i; fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' -e "s~\$IRIS_ADMIN_NAME~$IRIS_ADMIN_NAME~g" $i
            sed -i '' -e "s~\$IRIS_ADMIN_ORGANIZATION_NAME~$IRIS_ADMIN_ORGANIZATION_NAME~g" $i
            if [[ $IRIS_ENABLED = false ]]; then sed -i '' -e "/--link iris:iris/d" $i; fi
            if [[ $RETRIEVAL_ENABLED = false ]]; then sed -i '' -e "/--link retrieval:retrieval/d" $i; fi
            if [[ $BIOFORMAT_ENABLED = false ]]; then sed -i '' -e "/--link bioformat:bioformat/d" $i; fi
            if [[ $IIP_JP2_ENABLED = false ]]; then sed -i '' -e "/--link iipJP2:iipJP2/d" $i; fi
            if [[ $SOFTWARE_ENABLED = false ]]; then sed -i '' -e "/--link rabbitmq:rabbitmq/d" $i; fi
            if [[ $CORE_DEVELOPMENT = true ]]; then 
                sed -i '' -e "/--link core:core/d" $i
            else
                sed -i '' -e "/-p 5672:5672 -p 15672:15672/d" $i
                sed -i '' -e "/-p 5432:5432/d" $i
                sed -i '' -e "/-p 27017:27017 -p 28017:28017/d" $i
                sed -i '' -e "/-p 10022:22/d" $i
                sed -i '' -e "/-p 22/d" $i
            fi
            if [[ $IMS_DEVELOPMENT = true ]]; then sed -i '' -e "/--link ims:ims/d" $i; fi
        fi
    fi
done

mv utils/start.sh ./start.sh
