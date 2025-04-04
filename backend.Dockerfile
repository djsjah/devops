FROM maven:3.9.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

COPY ./React-Springboot-App/backend /app

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/target/*.jar app.jar

USER appuser

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
