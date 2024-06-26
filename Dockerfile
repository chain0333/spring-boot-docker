FROM maven:3.8.6-openjdk-18 AS build
WORKDIR usr/src/app
COPY . ./
RUN mvn clean package
#
# Package stage
#

FROM openjdk:18-jdk-alpine
ARG JAR_NAME="spring-boot-docker"
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/target/${JAR_NAME}.jar ./app.jar
CMD ["java","-jar", "./app.jar"]
