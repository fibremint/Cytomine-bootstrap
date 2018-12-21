#
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
#

#URLs
CORE_URL=localhost-core
IMS_URL1=localhost-ims
UPLOAD_URL=localhost-upload
IRIS_URL=localhost-iris
RETRIEVAL_URL=localhost-retrieval


#Paths
IMS_STORAGE_PATH=/data/images
IMS_BUFFER_PATH=/data/_buffer
SOFTWARE_CODE_PATH=/data/softwares/code
SOFTWARE_DOCKER_IMAGES_PATH=/data/softwares/images
JOBS_PATH=/data/jobs
SERVER_SSHKEYS_PATH=/data/ssh
RETRIEVAL_PATH=/data/thumb
FAST_DATA_PATH=/data/images
BACKUP_PATH=/data/backup


#Backups
# BACKUP_BOOL : backup active or not
BACKUP_BOOL=false
# SENDER_EMAIL, SENDER_EMAIL_PASS, SENDER_EMAIL_SMTP : email params of the sending account
SENDER_EMAIL_PASS='passwd'
SENDER_EMAIL_SMTP_HOST='smtp.gmail.com'
SENDER_EMAIL_SMTP_PORT='587'
SENDER_EMAIL='your.email@gmail.com'
# RECEIVER_EMAIL : email address of the receiver
RECEIVER_EMAIL='receiver@XXX.com'


#middlewares
RETRIEVAL_PASSWORD='retrieval_default'
RABBITMQ_LOGIN="router"
RABBITMQ_PASSWORD="router"


#IRIS
IRIS_ENABLED=false
IRIS_ID="LOCAL_CYTOMINE_IRIS"
IRIS_ADMIN_NAME="Ian Admin"
IRIS_ADMIN_ORGANIZATION_NAME="University of Somewhere, Department of Whatever"
IRIS_ADMIN_EMAIL="ian.admin@somewhere.edu"


# ADVANCED CONFIGURATION
# ---------------------------
IIP_OFF_URL=localhost-iip-cyto
IIP_CYTO_URL=localhost-iip-cyto
IIP_JP2_URL=localhost-iip-jp2000

RETRIEVAL_ENGINE=redis #possible values : memory, redis
MEMCACHED_PASS="mypass"
NB_IIP_PROCESS=10

BIOFORMAT_ENABLED=true
BIOFORMAT_ALIAS="bioformat"
BIOFORMAT_PORT="4321"
