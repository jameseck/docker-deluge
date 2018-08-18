FROM alpine:edge
MAINTAINER James Eckersall <james.eckersall@gmail.com>

RUN \
  echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
<<<<<<< HEAD
  apk add bash curl deluge@testing openvpn py2-pip privoxy rsync supervisor strongswan xl2tpd ppp && \
=======
  apk add bash bind-tools curl deluge@testing grep openvpn py2-pip privoxy rsync sed supervisor && \
  chmod -R 0777 /var/log /run && \
>>>>>>> 0749f160f2191510b9f7ccc9b49d27b218ebdeba
  rm -rf /var/cache/apk/*

RUN \
  pip install automat constantly incremental service_identity

COPY files /

RUN \
  mkdir -p /var/run/xl2tpd /config /torrents && \
  touch /var/run/xl2tpd/l2tp-control && \
  chmod -R 0777 /var/log /run && \
  chmod -R 0777 /config /scripts /torrents /run /var/log && \
  chmod -R 0755 /hooks/ && \
  chmod -R 0644 /etc/supervisord.conf /etc/supervisord.d/*.ini

ENV \
  AUTOADD_LOCATION=/torrents/drop \
  CONFIG_DIR=/config \
  DAEMON_PORT=58846 \
  DELUGE_PASSWORD=deluge \
  DOWNLOAD_LOCATION=/torrents/.in_progress \
  GEOIP_DB=/config/GeoIP/GeoIP.dat \
  LISTEN_PORTS=6881,6891 \
  MOVE_COMPLETED_PATH=/torrents/completed \
  PLUGINS_LOCATION=/config/deluge/plugins \
  PYTHON_EGG_CACHE=/config/deluge/plugins \
  RANDOM_PORT=false \
  TORRENTFILES_LOCATION=/torrents/.torrents \
  TORRENTS_DIR=/torrents \
  UPNP=false \
  WEB_PORT=8112 \
  LOGLEVEL=info \
  VPN_PSK='torguard' \
  LAN_NETWORK=192.168.0.0/16 \
  NAME_SERVERS=8.8.8.8,9.9.9.9 \
  VPN_CONFIG=/config/openvpn/openvpn.ovpn \
  VPN_DEVICE_TYPE=tun \
  VPN_PROV=tg \
  VPN_REMOTE=88.150.157.14 \
  VPN_REMOTE_PORT=1912 \
  VPN_PROTOCOL=udp \
  VPN_USERNAME=bob \
  VPN_PASSWORD=pass

VOLUME ["/torrents", "/config"]

EXPOSE 45682 8112/tcp 53160/tcp 53160/udp 58846/tcp

ENTRYPOINT ["/bin/bash", "-e", "/init/entrypoint"]
CMD ["run"]
