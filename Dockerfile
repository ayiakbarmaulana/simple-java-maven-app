#
# Build stage
#
FROM maven:3.9.2 AS build
USER root
COPY src /home/ubuntu/simple-java-maven-app/src
COPY pom.xml /home/ubuntu/simple-java-maven-app
RUN mvn -f /home/ubuntu/simple-java-maven-app/pom.xml clean package

#
# Package stage
#
FROM openjdk:17-jdk-slim
COPY --from=build /home/ubuntu/simple-java-maven-app/target/*.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/app.jar"]