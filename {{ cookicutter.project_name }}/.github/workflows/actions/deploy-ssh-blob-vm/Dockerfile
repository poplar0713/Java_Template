# Dockerfile for GitHub Action
FROM alpine:latest

# Install SSH client and other necessary tools
RUN apk add --no-cache openssh-client jq curl

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint script to be the container's entrypoint
ENTRYPOINT ["/entrypoint.sh"]