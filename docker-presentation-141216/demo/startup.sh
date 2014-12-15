#!/bin/bash

# unzip bundle
tomcat_folder=BonitaBPMSubscription-${bonita_version}-Tomcat-${tomcat_version}
unzip -q ${tomcat_folder}.zip

# install license
cp /lic/*.lic ${tomcat_folder}/bonita/server/licenses

if [ $? -ne 0 ]; then
  echo "WARNING! Failed to copy .lic to Tomcat folder - Tomcat won't be started"
  exit 1
fi

# and let it go!
cd ${tomcat_folder}/bin
./catalina.sh run
