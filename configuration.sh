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



# -----------------------------------------------------------------------------
# Check Cytomine configuration reference for details:
# > https://doc.cytomine.be/display/PubOp/Cytomine+configuration+reference
#
# Advanced configuration should be edited only if you know what you are doing.
# -----------------------------------------------------------------------------

#------------------------------------------------------------------------------
# BIAFLOWS configuration
#------------------------------------------------------------------------------

# These URLs have to be accessible (add them to /etc/hosts if you run it locally)
UI_URL=biaflows
CORE_URL=biaflows
IMS_URL=biaflows-ims
UPLOAD_URL=biaflows-upload

# These paths must exist
IMS_STORAGE_PATH=/biaflows/data/images
IMS_BUFFER_PATH=/biaflows/data/_buffer
FAST_DATA_PATH=/biaflows/data/images
SOFTWARE_DOCKER_IMAGES_PATH=/biaflows/data/softwares/images
SERVER_SSHKEYS_PATH=/biaflows/data/ssh
PROXY_CACHE_PATH=/biaflows/data/cache

# Ask workflows to compute metrics and upload results to BIAFLOWS
BIAFLOWS_WORKFLOWS_METRICS=false

# Upload to BIAFLOWS resulting annotations produced by workflow executions
BIAFLOWS_WORKFLOWS_EXPORT=true

###############################################################################
###############################################################################
###############################################################################
#------------------------------------------------------------------------------
# ADVANCED CYTOMINE CONFIGURATION
# - Do not touch instead you know what you are doing.
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# Core
#------------------------------------------------------------------------------
SENDER_EMAIL_SMTP_HOST='smtp.gmail.com'
SENDER_EMAIL_SMTP_PORT='587'
SENDER_EMAIL_PASS='passwd'
SENDER_EMAIL='your.email@gmail.com'

# Advanced configuration.
CORE_DEVELOPMENT=false
POSTGRESQL_VOLUME=db_biaflows_sql
MONGODB_VOLUME=db_biaflows_nosql

#------------------------------------------------------------------------------
# IMS
#------------------------------------------------------------------------------
# Advanced configuration.
IMS_DEVELOPMENT=false

IIP_OFF_URL=localhost-iip-cyto
IIP_CYTO_URL=localhost-iip-cyto
MEMCACHED_PASS="mypass"
NB_IIP_PROCESS=10

#------------------------------------------------------------------------------
# PLUGIN: BACKUP
#------------------------------------------------------------------------------
BACKUP_ENABLED=false
RECEIVER_EMAIL='receiver@XXX.com'
BACKUP_PATH=/data/backup

#------------------------------------------------------------------------------
# PLUGIN: RETRIEVAL
#------------------------------------------------------------------------------
RETRIEVAL_ENABLED=true
RETRIEVAL_URL=localhost-retrieval
RETRIEVAL_PATH=/data/thumb

# Advanced configuration.
RETRIEVAL_PASSWORD='retrieval_default'
RETRIEVAL_ENGINE=redis #possible values : memory, redis

#------------------------------------------------------------------------------
# PLUGIN: BIOFORMAT
#------------------------------------------------------------------------------
BIOFORMAT_ENABLED=true

#------------------------------------------------------------------------------
# PLUGIN: IIP-JP2 (JPEG 2000 native support)
#------------------------------------------------------------------------------
IIP_JP2_ENABLED=true

# Advanced configuration.
IIP_JP2_URL=localhost-iip-jp2000

#------------------------------------------------------------------------------
# PLUGIN: IRIS
#------------------------------------------------------------------------------
IRIS_ENABLED=false
IRIS_URL=localhost-iris
IRIS_ADMIN_NAME="Ian Admin"
IRIS_ADMIN_ORGANIZATION_NAME="University of Somewhere, Department of Whatever"
IRIS_ADMIN_EMAIL="ian.admin@somewhere.edu"

# Advanced configuration.
IRIS_ID="LOCAL_CYTOMINE_IRIS"
IRIS_VOLUME=iris_data

#------------------------------------------------------------------------------
# PLUGIN: SOFTWARE
#------------------------------------------------------------------------------
SOFTWARE_ENABLED=true
SOFTWARE_CODE_PATH=/biaflows/data/softwares/code
JOBS_PATH=/biaflows/data/jobs

# Advanced configuration.
RABBITMQ_LOGIN="router"
RABBITMQ_PASSWORD="router"
SLURM_VOLUME=slurm_data

#-------------------------------------------------------------------------------
# HTTPS FOR PUBLIC URLS
#-------------------------------------------------------------------------------

# Protocol for URLs accessible from outside (CORE_URL, IMS_URL, UPLOAD_URL, IRIS_URL)
HTTP_PROTOCOL=http # Accepted values: http, https
HTTP_PROXY=false

# Path where certificates are stored:
CERTIFICATE_PATH=/biaflows/data/certificates

# To use HTTPS protocol, you need the following certificates in your CERTIFICATE_PATH
# - ${CORE_URL}.pem (ex: localhost-core.pem)
# - ${CORE_URL}-key.pem (ex: localhost-core-key.pem)
# - ${IMS_URL}.pem
# - ${IMS_URL}-key.pem
# - ${UPLOAD_URL}.pem
# - ${UPLOAD_URL}-key.pem
# - ${IRIS_URL}.pem - only if $IRIS_ENABLED = true
# - ${IRIS_URL}-key.pem - only if $IRIS_ENABLED = true

INSTANCE_PREFIX=""
HTTP_NGINX_PORT=80
HTTPS_NGINX_PORT=443