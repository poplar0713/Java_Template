#!/bin/sh -l

# Environment variables passed from the workflow
ENVIRONMENT=$1
STORAGE_ACCOUNT=$2
STORAGE_CONTAINER=$3
STORAGE_ACCESS_KEY=$4
SSH_PRIVATE_KEY=$5
VM_IP=$6
VM_USER=$7
APP_NAME=$8

# Setup SSH key
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Login to Azure Blob Storage to fetch the .jar file
az storage blob download \
    --account-name $STORAGE_ACCOUNT \
    --container-name $STORAGE_CONTAINER \
    --name $APP_NAME.jar \
    --file $APP_NAME.jar \
    --auth-mode key \
    --account-key $STORAGE_ACCESS_KEY

# Deploy the application via SSH
ssh -o StrictHostKeyChecking=no $VM_USER@$VM_IP "mkdir -p /app"
scp -o StrictHostKeyChecking=no $APP_NAME.jar $VM_USER@$VM_IP:/app/

# Execute the application
ssh -o StrictHostKeyChecking=no $VM_USER@$VM_IP "java -jar /app/$APP_NAME.jar"

echo "Deployment completed successfully."