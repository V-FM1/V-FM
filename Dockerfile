FROM debian:bullseye-slim

# Create icecast user and group
RUN apt-get update && \
    apt-get install -y icecast2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r icecast && \
    useradd -r -g icecast icecast && \
    mkdir -p /usr/local/icecast/logs && \
    chown -R icecast:icecast /usr/local/icecast

# Copy config
COPY icecast.xml /etc/icecast2/icecast.xml

# Run Icecast as non-root
USER icecast

CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]
