FROM ubuntu:20.04

RUN apt update && apt install -y icecast2

COPY icecast.xml /etc/icecast2/icecast.xml

EXPOSE 8000

CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
