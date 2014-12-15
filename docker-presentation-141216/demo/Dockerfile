FROM dockerfile/java:openjdk-7-jdk

MAINTAINER Truc Nguyen <truc.nguyen@bonitasoft.com>


# create lic folder
RUN mkdir /lic

# download bundles
ENV base_url http://192.168.1.254/qa/releases
# 6.0.0
RUN wget --quiet \
${base_url}/6.0-GA/BonitaBPMSubscription-6.0/BonitaBPMSubscription-6.0.0-Tomcat-6.0.35.zip
# 6.1.0
RUN wget --quiet \
${base_url}/6.1.0/BonitaBPMSubscription-6.1.0/BonitaBPMSubscription-6.1.0-Tomcat-6.0.37.zip
# 6.2.0
RUN wget --quiet \
${base_url}/6.2.0/BonitaBPMSubscription-6.2.0/BonitaBPMSubscription-6.2.0-Tomcat-6.0.37.zip
# 6.3.0
RUN wget --quiet \
${base_url}/6.3.0/BonitaBPMSubscription-6.3.0/BonitaBPMSubscription-6.3.0-Tomcat-6.0.37.zip
# 6.4.0
RUN wget --quiet \
${base_url}/6.4.0/BonitaBPMSubscription-6.4.0/BonitaBPMSubscription-6.4.0-Tomcat-7.0.55.zip


# environment variables can be overridden
ENV bonita_version 6.4.0
ENV tomcat_version 7.0.55

# add startup script to container
ADD startup.sh /data/

# mount lic volume
VOLUME /lic

# expose Tomcat port
EXPOSE 8080

# command to run when container starts
CMD ["/data/startup.sh"]
