#!/bin/bash
set -e  # exit if any command fails

APP_NAME="spring-sample"
IMAGE_NAME="retail/${APP_NAME}"
IMAGE_TAG="1.0.0"
DTR_REGISTRY="dtr.company.local"   # replace with your DTR hostname
DTR_USER="your-username"           # set via env var or replace
DTR_PASS="your-password"           # set via env var or replace

echo ">>> Step 1: Clean & build Spring Boot app (Maven package)"
mvn -B clean package -DskipTests

echo ">>> Step 2: Build Docker image"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo ">>> Step 3: Run container locally (background)"
docker rm -f ${APP_NAME}-container 2>/dev/null || true
docker run -d --name ${APP_NAME}-container -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}

echo ">>> Waiting for app to come up..."
sleep 5

echo ">>> Step 4: Test endpoints"
curl -s http://localhost:8080/hello || echo "Endpoint failed"
curl -s http://localhost:8080/actuator/health || echo "Health check failed"

echo ">>> Step 5: Scan Docker image with Trivy"
if ! command -v trivy >/dev/null 2>&1; then
  echo "Trivy not found. Installing..."
  sudo apt-get update && sudo apt-get install -y wget
  wget -qO- https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
fi
trivy image --severity HIGH,CRITICAL ${IMAGE_NAME}:${IMAGE_TAG}

echo ">>> Step 6: Tag for DTR"
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DTR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

echo ">>> Step 7: Login & push to DTR"
echo "${DTR_PASS}" | docker login ${DTR_REGISTRY} -u ${DTR_USER} --password-stdin
docker push ${DTR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}

echo ">>> Done. Container is running locally, and image pushed to DTR."
