FROM maven:3-openjdk-18-slim as maven
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn clean install -DskipTests=true
FROM maven:3-openjdk-18-slim
WORKDIR /application/
COPY --from=maven /build/target/*.jar ./
RUN ls /application/
EXPOSE 8080
ENTRYPOINT ["java","-jar","jb-hello-world-maven-0.2.0.jar"]
