FROM debian:bullseye-slim

# Install Icecast and dependencies
RUN apt-get update && \
    apt-get install -y icecast2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Only create group if it doesn't exist
RUN getent group icecast || groupadd -r icecast

# Only create user if it doesn't exist
RUN id -u icecast &>/dev/null || useradd -r -g icecast icecast

# Create logs folder and assign permissions
RUN mkdir -p /usr/local/icecast/logs && \
    chown -R icecast:icecast /usr/local/icecast

# Copy your Icecast config file
COPY icecast.xml /etc/icecast2/icecast.xml

# Run Icecast as non-root
USER icecast

# Start the server
CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]

