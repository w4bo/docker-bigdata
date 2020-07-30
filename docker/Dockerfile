FROM ubuntu:bionic

ARG ZEPPELIN_VERSION="0.8.1"
ARG SPARK_VERSION="2.4.3"
ARG HADOOP_VERSION="2.7"

LABEL maintainer "mirkoprescha"
LABEL zeppelin.version=${ZEPPELIN_VERSION}
LABEL spark.version=${SPARK_VERSION}
LABEL hadoop.version=${HADOOP_VERSION}

# Install Java and some tools
RUN apt-get -y update && apt-get -y install curl less openjdk-8-jdk vim python3.6
RUN ln -s /usr/bin/python3.6 /usr/bin/python

##########################################
# SPARK
##########################################
ARG SPARK_ARCHIVE=https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN mkdir /usr/local/spark &&\
    mkdir /tmp/spark-events    # log-events for spark history server
ENV SPARK_HOME /usr/local/spark
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -s ${SPARK_ARCHIVE} | tar -xz -C  /usr/local/spark --strip-components=1
COPY spark-defaults.conf ${SPARK_HOME}/conf/

##########################################
# WORKDIR
##########################################
RUN mkdir /work
WORKDIR /work

##########################################
# Zeppelin
##########################################
RUN mkdir /usr/zeppelin &&\
    curl -s https://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz | tar -xz -C /usr/zeppelin
RUN echo '{ "allow_root": true }' > /root/.bowerrc

ENV ZEPPELIN_PORT 8080
EXPOSE $ZEPPELIN_PORT

ENV ZEPPELIN_HOME /usr/zeppelin/zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR /work/notebook

RUN mkdir -p $ZEPPELIN_HOME \
    && mkdir -p $ZEPPELIN_HOME/logs \
    && mkdir -p $ZEPPELIN_HOME/run

ENTRYPOINT  /usr/local/spark/sbin/start-history-server.sh; $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start && bash