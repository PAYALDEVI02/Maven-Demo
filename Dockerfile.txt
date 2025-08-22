# Build with Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY Myspace/src ./src

# Package the application
RUN mvn clean package -DskipTests

# Expose the port your app runs on 
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
