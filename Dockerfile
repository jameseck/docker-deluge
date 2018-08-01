FROM alpine
MAINTAINER James Eckersall <james.eckersall@gmail.com>

RUN \
  echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add bash bind-tools curl deluge@testing grep openvpn py2-pip privoxy rsync sed supervisor && \
  chmod -R 0777 /var/log /run && \
  rm -rf /var/cache/apk/*

RUN \
  pip install automat constantly incremental service_identity

COPY files /

RUN \
  mkdir /config /torrents && \
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
  LAN_NETWORK=192.168.0.0/16 \
  LOGLEVEL=info \
  NAME_SERVERS=8.8.8.8,9.9.9.9 \
  VPN_CONFIG=/config/openvpn/openvpn.ovpn \
  VPN_DEVICE_TYPE=tun \
  VPN_PROV=pia \
  VPN_REMOTE=uk-london.privateinternetaccess.com \
  VPN_REMOTE_PORT=1198 \
  VPN_USERNAME=bob \
  VPN_PASSWORD=pass

VOLUME ["/torrents", "/config"]

EXPOSE 45682 8112/tcp 53160/tcp 53160/udp 58846/tcp

ENTRYPOINT ["/bin/bash", "-e", "/init/entrypoint"]
CMD ["run"]
