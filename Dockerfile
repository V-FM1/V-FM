FROM debian:bullseye-slim

# Create a new user called icecast
RUN useradd -m icecastuser

# Install Icecast
RUN apt-get update && \
    apt-get install -y icecast2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your config file
COPY icecast.xml /etc/icecast2/icecast.xml

# Use the new non-root user
USER icecastuser

# Start Icecast in foreground
CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]

