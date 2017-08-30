FROM openjdk:8-jdk

LABEL maintainer="jaroslav.barton@comsource.cz"

ENV KAFKA_MANAGER_VERSION 1.3.3.13

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KAFKA_MANAGER_VERSION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KAFKA_MANAGER_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2

EXPOSE 9000

VOLUME /kafka-manager-${KAFKA_MANAGER_VERSION}/conf

WORKDIR /kafka-manager-${KAFKA_MANAGER_VERSION}
CMD bin/kafka-manager
