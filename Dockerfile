FROM maven:3-openjdk-18-slim as maven
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn clean install -DskipTests=true
FROM maven:3-openjdk-18-slim
WORKDIR /application/
COPY --from=maven /build/target/*.jar ./
RUN ls /application/
ENTRYPOINT ["java","-jar","*.jar"]
