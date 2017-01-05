FROM jameseckersall/alpine-base:3.5
MAINTAINER James Eckersall <james.eckersall@gmail.com>


RUN \
  echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add py2-pip deluge@testing && \
  pip install service_identity && \
  rm -rf /var/cache/apk/*

COPY files /

RUN \
  mkdir /torrents && \
  chmod -R 0777 /config /torrents && \
  chmod +x /hooks/supervisord-pre.d/*

EXPOSE 45682 8112/tcp 53160/tcp 53160/udp 58846/tcp
