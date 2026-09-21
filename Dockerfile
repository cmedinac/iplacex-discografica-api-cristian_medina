# Stage 1: Build con Gradle
FROM gradle:8.5-jdk21 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon -x test

# Stage 2: Ejecución con OpenJDK
FROM eclipse-temurin:21-jdk-jammy
EXPOSE 8080
# Se copia el compilado desde el stage 1. El nombre asume rootProject.name = 'discografia' y version = '1'
COPY --from=build /home/gradle/src/build/libs/discografia-1.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]