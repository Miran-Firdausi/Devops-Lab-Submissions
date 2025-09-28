#!/bin/bash

echo "✅ Starting MongoDB + Mongo Express deployment..."

# Step 1: Apply Secret
echo "Applying Secret..."
kubectl apply -f k8s/mongo-secret.yaml

# Step 2: Apply ConfigMap
echo "Applying ConfigMap..."
kubectl apply -f k8s/mongo-configmap.yaml

# Step 3: Deploy MongoDB
echo "Deploying MongoDB..."
kubectl apply -f k8s/mongo-deployment.yaml

# Step 4: MongoDB Service
echo "Creating MongoDB Service..."
kubectl apply -f k8s/mongo-service.yaml

# Step 5: Deploy Mongo Express
echo "Deploying Mongo Express..."
kubectl apply -f k8s/mongo-express-deployment.yaml

# Step 6: Mongo Express Service
echo "Creating Mongo Express Service..."
kubectl apply -f k8s/mongo-express-service.yaml

# Step 7: Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=mongo --timeout=60s
kubectl wait --for=condition=Ready pod -l app=mongo-express --timeout=60s

# Step 8: Display pod and service status
echo "🚀 Deployment complete. Status:"
kubectl get pods
kubectl get svc

echo "Access Mongo Express via NodePort:"
kubectl get svc mongo-express-service
