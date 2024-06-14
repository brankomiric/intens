FROM openjdk:alpine AS builder

WORKDIR /app

COPY . .

RUN \
    # Install Maven
    apk add --no-cache maven \
    # Run tests
    && mvn test \
    # Package
    && mvn package

FROM openjdk:alpine

ENV PORT=8080

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]