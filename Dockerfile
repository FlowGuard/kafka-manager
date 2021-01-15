FROM openjdk:11-jdk

LABEL maintainer="jaroslav.barton@comsource.cz"

ENV KAFKA_MANAGER_VERSION 3.0.0.5

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/CMAK kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KAFKA_MANAGER_VERSION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/cmak-${KAFKA_MANAGER_VERSION}.zip && \
    ln -s /cmak-${KAFKA_MANAGER_VERSION} /kafka-manager && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2

EXPOSE 9000

VOLUME /kafka-manager/conf

WORKDIR /kafka-manager
CMD rm RUNNING_PID; bin/cmak
