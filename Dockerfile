FROM gradle:8.10-jdk21 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon -x test

FROM eclipse-temurin:21-jdk-jammy
EXPOSE 8080
COPY --from=build /home/gradle/src/build/libs/discografia-1.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]