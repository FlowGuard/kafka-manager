FROM openjdk:8-jdk

LABEL maintainer="ondrej.kinovic@comsource.cz"

ENV KAFKA_MANAGER_VERSION 2.0.0.2

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KAFKA_MANAGER_VERSION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KAFKA_MANAGER_VERSION}.zip && \
    mv /kafka-manager-${KAFKA_MANAGER_VERSION} /kafka-manager && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2

EXPOSE 9000

VOLUME /kafka-manager/conf

WORKDIR /kafka-manager
CMD rm RUNNING_PID; bin/kafka-manager
