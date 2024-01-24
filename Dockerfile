FROM eclipse-temurin:17-jdk-jammy AS build
ENV HOME=/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD ./testbnp-backend/ $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

FROM eclipse-temurin:17-jre-jammy 
ARG JAR_FILE=/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
EXPOSE 80
ENTRYPOINT java -jar /app/runner.jar