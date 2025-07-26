FROM debian:bullseye-slim

# Create non-root user icecast
RUN groupadd -r icecast && useradd -r -g icecast icecast

# Install Icecast
RUN apt-get update &&     apt-get install -y icecast2 &&     apt-get clean &&     rm -rf /var/lib/apt/lists/*

# Set ownership of Icecast dirs
RUN mkdir -p /var/log/icecast2 /var/run/icecast &&     chown -R icecast:icecast /etc/icecast2 /var/log/icecast2 /var/run/icecast

COPY icecast.xml /etc/icecast2/icecast.xml

# Switch to non-root user
USER icecast

# Run Icecast
CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]