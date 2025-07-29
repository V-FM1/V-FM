FROM debian:bullseye-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y icecast2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create icecast group and user safely
RUN groupadd -f icecast && \
    getent passwd icecast || useradd -r -g icecast icecast

# Create logs directory and set ownership
RUN mkdir -p /usr/local/icecast/logs && \
    chown -R icecast:icecast /usr/local/icecast

COPY icecast.xml /etc/icecast2/icecast.xml

USER icecast

EXPOSE 8000

CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
