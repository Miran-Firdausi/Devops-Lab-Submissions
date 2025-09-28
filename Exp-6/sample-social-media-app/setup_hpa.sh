#!/bin/bash

# Set deployment name
DEPLOYMENT_NAME="social-app"

# Apply HPA
kubectl autoscale deployment $DEPLOYMENT_NAME \
  --cpu-percent=50 \
  --min=2 \
  --max=5

# Show HPA status
kubectl get hpa
