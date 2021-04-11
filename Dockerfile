# Dockerfile for backend


FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package -DskipTests
 
FROM tomcat:9.0-jre8-alpine
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/eschool.jar eschool.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "eschool.jar"]




ENV DATASOURCE_URL="jdbc:mysql://${DATASOURCE_URL}/eschool?useUnicode=true&characterEncoding=utf8&createDatabaseIfNotExist=true&&autoReconnect=true&useSSL=false"
ENV DATASOURCE_USERNAME="${DATASOURCE_USERNAME}"
ENV DATASOURCE_PASSWORD="${DATASOURCE_PASSWORD}"