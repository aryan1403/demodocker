#
# Build stage
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src /demo/src
COPY pom.xml /demo
RUN mvn -f "/demo/pom.xml" clean package

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /demo/target/demo-0.0.1-SNAPSHOT.jar /demo/target/demo-0.0.1-SNAPSHOT
COPY --from=build /demo/target /demo/target
ENTRYPOINT ["java","-jar","/demo/target/demo-0.0.1-SNAPSHOT.jar"]