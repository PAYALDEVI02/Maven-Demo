# Build with Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline 

COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Expose the port your app runs on 
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "target/demo-app-0.0.1-SNAPSHOT.jar"]
