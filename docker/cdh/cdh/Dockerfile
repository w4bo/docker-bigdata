FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    CM_MAJOR_VERSION=6 \
    CM_MINOR_VERSION=3 \
    CM_PATCH_VERSION=1

ENV CM_VERSION=${CM_MAJOR_VERSION}.${CM_MINOR_VERSION}.${CM_PATCH_VERSION}
ENV CLOUDERA_BASE_URL=https://archive.cloudera.com/cm${CM_MAJOR_VERSION}/${CM_VERSION}/ubuntu1804/apt/

# Install Java8(OpenJDK), MySQL JDBC driver and configure Cloudera Repo
RUN apt-get update &&\
    apt-get install --quiet --no-install-recommends --yes \
        wget \
        gnupg2 \
        ca-certificates \
        openjdk-8-jdk \
        python-pip \ 
	mysql-server libmysql-java &&\
    wget -q ${CLOUDERA_BASE_URL}/cloudera-manager.list -P /etc/apt/sources.list.d &&\
    wget -q ${CLOUDERA_BASE_URL}/archive.key -O - | apt-key add - &&\
    rm -rf /var/lib/apt/lists/*

# postgresql libpostgresql-jdbc-java \
# RUN pip install psycopg2==2.7.5 --ignore-installed

# Install cloudera-manager-{server,daemons}
RUN apt-get update &&\
    apt-get install --quiet --yes cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server &&\
    rm -rf /var/lib/apt/lists/*

EXPOSE 7180 7182

# #############################################################################
# Enable SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
# END - SSH
# #############################################################################

COPY ./db.properties /etc/cloudera-scm-server/db.properties
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
# ENTRYPOINT bash
ENTRYPOINT /usr/sbin/sshd -D && /docker-entrypoint.sh start
# CMD ["/docker-entrypoint.sh", "start"]
