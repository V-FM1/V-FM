FROM debian:bullseye-slim

RUN apt-get update &&     apt-get install -y icecast2 &&     apt-get clean &&     rm -rf /var/lib/apt/lists/* &&     groupadd -f icecast &&     id -u icecast &>/dev/null || useradd -r -g icecast icecast &&     mkdir -p /usr/local/icecast/logs &&     chown -R icecast:icecast /usr/local/icecast

COPY icecast.xml /etc/icecast2/icecast.xml

USER icecast

CMD ["/usr/bin/icecast2", "-c", "/etc/icecast2/icecast.xml"]