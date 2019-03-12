#!/bin/bash

# Copyright (c) 2009-2019. Authors: see NOTICE file.
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

#################################### Usage ####################################
#
# bash ./inject_demo_data.sh ADMIN_PUBLIC_KEY ADMIN_PRIVATE_KEY
# where ADMIN_*_KEY are the API keys of the automatically created "admin" user.
# In the webUI, you can find them at the end of "Account" page.

# If you just installed Cytomine, you can run this script without any argument
# as the admin keys stored in this script are still valid.
###############################################################################

. utils/keys.sh
. ./configuration.sh
. ./configuration-versions.sh

docker create --rm --name project_migrator \
-e CORE_URL=$CORE_URL \
-e UPLOAD_URL=$UPLOAD_URL \
-e PUBLIC_KEY=${1:-$ADMIN_PUB_KEY} \
-e PRIVATE_KEY=${2:-$ADMIN_PRIV_KEY} \
$PROJECT_MIGRATOR_NAMESPACE/project_migrator:$PROJECT_MIGRATOR_VERSION import /tmp/projects.txt

docker cp $PWD/configs/project_migrator/projects.txt project_migrator:/tmp/projects.txt
docker cp $PWD/hosts/project_migrator/addHosts.sh project_migrator:/tmp/addHosts.sh
docker start -ai project_migrator
