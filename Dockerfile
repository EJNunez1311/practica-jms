FROM openjdk:8
VOLUME /tmp
COPY build/libs/jms-main-0.0.1-SNAPSHOT.jar practica-jms.jar
EXPOSE 4567
ENTRYPOINT ["java","-jar","practica-jms.jar"]