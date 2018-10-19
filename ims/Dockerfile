#
# Copyright (c) 2009-2017. Authors: see NOTICE file.
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

FROM cytomineuliege/tomcat7

MAINTAINER Cytomine Team "support@cytomine.be"

RUN apt-get -y update && apt-get install -y ant \
      automake \
      dnsutils \
      git \
      gobject-introspection \
      gtk-doc-tools \
      libfftw3-dev \
	  libgsf-1-dev \
	  libglib2.0-dev \
      libjpeg8-dev \
      libopenexr-dev \
      libopenjpeg-dev \
      liborc-0.4-0 \
      liborc-0.4-dev \
      libtiff5-dev \
      libtiff-tools \
      libtool \
      libxml2-dev \
      software-properties-common \
      swig && \
    apt-get -y build-dep openslide libvips-dev

#openslide
RUN cd /tmp && git clone https://github.com/openslide/openslide && cd /tmp/openslide && git checkout 4cd4b83c3ffff0382126d0618c85407f2c469b28 && autoreconf -i && ./configure && make && make install

# use previous lib of lipopenjpeg-dev due to the bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=734238
#RUN cd /tmp && wget http://launchpadlibrarian.net/147357170/libopenjpeg2_1.3%2Bdfsg-4.6ubuntu2_amd64.deb && dpkg -i libopenjpeg2_1.3+dfsg-4.6ubuntu2_amd64.deb
#RUN cd /tmp && wget http://launchpadlibrarian.net/147357169/libopenjpeg-dev_1.3%2Bdfsg-4.6ubuntu2_amd64.deb && dpkg -i libopenjpeg-dev_1.3+dfsg-4.6ubuntu2_amd64.deb

# imagemagick 6.8.9-10 (fix problem with DICOM conversion by vips on Ubuntu 14.04)
RUN cd /tmp && wget https://www.imagemagick.org/download/releases/ImageMagick-6.8.9-10.tar.xz && tar xf ImageMagick-6.8.9-10.tar.xz && cd ImageMagick-6.8.9-10 && ./configure && make && make install && ldconfig /usr/local/lib

# vips
RUN cd /tmp && wget https://github.com/jcupitt/libvips/releases/download/v8.5.1/vips-8.5.1.tar.gz && tar -zxvf ./vips-8.5.1.tar.gz && cd ./vips-8.5.1 && LDFLAGS="-L/usr/local/lib -lopenslide" CPPFLAGS="-I/usr/local/include/openslide"  ./configure && make && make install


#openslide-java
RUN update-java-alternatives -s java-8-oracle
RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle && export CFLAGS="-I/usr/lib/jvm/java-8-oracle" && cd /tmp && git clone https://github.com/cytomine/openslide-java && cd /tmp/openslide-java && git checkout 93af97eeca8f0b63e9f71a6916af474ecc474dc8 && autoreconf -i && ./configure && make && make install


EXPOSE 8081
EXPOSE 8082

RUN ldconfig -v

ARG version=0.10
RUN rm -r /var/lib/tomcat7/webapps/* && cd /var/lib/tomcat7/webapps/ &&  wget -q https://github.com/Neubias-WG5/Cytomine-IMS/releases/download/v${version}/ims.war -O ROOT.war
#RUN cd /var/lib/tomcat7/  && wget -q http://release.cytomine.be/IMS/restapidoc.json -O restapidoc.json

ADD deploy.sh /tmp/deploy.sh
RUN chmod +x /tmp/deploy.sh
ADD setenv.sh /tmp/setenv.sh
RUN chmod +x /tmp/setenv.sh

ENTRYPOINT ["/tmp/deploy.sh"]

