FROM openjdk:8-jdk

LABEL maintainer="ondrej.kinovic@comsource.cz"

RUN wget http://www.kinovic.cz/files/kafka-manager-1.3.3.21.zip && \
	unzip  -d / kafka-manager-1.3.3.21.zip && \
    mv kafka-manager-1.3.3.21 /kafka-manager && \
    rm kafka-manager-1.3.3.21.zip

EXPOSE 9000

VOLUME /kafka-manager/conf

WORKDIR /kafka-manager
CMD rm RUNNING_PID; bin/kafka-manager
