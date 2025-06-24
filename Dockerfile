FROM n8nio/n8n:latest

# Install additional packages if needed
USER root
RUN apk add --no-cache git curl

# Switch back to node user
USER node

# Set working directory
WORKDIR /home/node/.n8n

# Create necessary directories
RUN mkdir -p /home/node/.n8n/nodes

# Expose port (Railway will set this automatically)
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:$PORT/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]
