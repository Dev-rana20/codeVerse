# ---- Stage 1: Build ----
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# Copy everything at once — avoids classpath/resolution issues during build
COPY . .

# Normalize Windows CRLF line endings to LF (fixes javac package resolution on Linux)
RUN find src -name "*.java" -exec sed -i 's/\r//' {} \;

RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# ---- Stage 2: Run ----
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /app/target/codeVerse-1.war app.war

EXPOSE 9999

ENTRYPOINT ["java", "-jar", "app.war"]