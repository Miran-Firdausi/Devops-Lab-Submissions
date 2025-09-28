# ---------- STAGE 1: build ----------
FROM maven:3.9.5-eclipse-temurin-17 as builder
WORKDIR /app

# only copy pom and download deps to leverage layer cache
COPY pom.xml .
COPY settings.xml /root/.m2/settings.xml  # optional, if you use private repo
RUN mvn -B -DskipTests dependency:go-offline

# copy source and build
COPY src ./src
RUN mvn -B -DskipTests package

# ---------- STAGE 2: runtime ----------
FROM eclipse-temurin:17-jre-alpine
LABEL maintainer="miran@example.com"
ENV TZ=Asia/Kolkata
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom"

# create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /opt/app
COPY --from=builder /app/target/*.jar app.jar

RUN chown -R appuser:appgroup /opt/app
USER appuser

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s \
  CMD wget -qO- --timeout=2 http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /opt/app/app.jar"]
