#!/bin/sh
CM_MAJOR_VERSION=6
CM_MINOR_VERSION=3
CM_PATCH_VERSION=1
CM_VERSION=${CM_MAJOR_VERSION}.${CM_MINOR_VERSION}.${CM_PATCH_VERSION}
CLOUDERA_BASE_URL=https://archive.cloudera.com/cm${CM_MAJOR_VERSION}/${CM_VERSION}/ubuntu1804/apt/

# Install Java8(OpenJDK), MySQL JDBC driver and configure Cloudera Repo
sudo apt update
sudo apt install --yes \
        wget gnupg2 ca-certificates vim ntp git \ # installing some utilities
        oracle-j2sdk1.8 \                         # installing java (error with openjdk-8-jdk)
	mysql-server libmysql-java 		  # installing mysql and java connector

# Add user to sudoers (required by cloudera manager)
sudo cp /etc/sudoers.orig /etc/sudoers
echo "bigdata ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/bigdata

# #############################################################################
# Enable NTP
sudo ufw allow from any to any port 123 proto udp
sudo service ntp restart
# End - NTP
# #############################################################################

# #############################################################################
# Enable MySQL
sudo mysql -u root < mysql/config.sql
# End - MySQL
# #############################################################################

# #############################################################################
# Enable CDH
sudo wget -q ${CLOUDERA_BASE_URL}/cloudera-manager.list -P /etc/apt/sources.list.d
sudo wget -q ${CLOUDERA_BASE_URL}/archive.key -O - | sudo apt-key add - 
sudo rm -rf /var/lib/apt/lists/*
# Install cloudera-manager-{server,daemons}
sudo apt update
sudo apt install --yes cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server
sudo rm -rf /var/lib/apt/lists/*
# sudo cp db.properties /etc/cloudera-scm-server/db.properties
sudo /opt/cloudera/cm/schema/scm_prepare_database.sh mysql scm scm password
sudo ufw allow 7182
# End - CDH
# #############################################################################

# #############################################################################
# Enable SSH
sudo apt install -y openssh-server
sudo ufw allow ssh
sudo systemctl enable --now ssh
# End - SSH
# #############################################################################

# chmod +x docker-entrypoint.sh
# sudo ./docker-entrypoint.sh start &
sudo service cloudera-scm-server start
# Check the logs here!!!
# sudo tail -f /var/log/cloudera-scm-agent/cloudera-scm-agent.log
# sudo tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log

