#!/bin/sh

[ ! -d /config/openvpn ] && mkdir --mode=0775 /config/openvpn
[ ! -f /config/openvpn/openvpn.ovpn ]     && cp /openvpn/openvpn.ovpn     /config/openvpn/
[ ! -f /config/openvpn/crl.rsa.2048.pem ] && cp /openvpn/crl.rsa.2048.pem /config/openvpn/
[ ! -f /config/openvpn/ca.rsa.2048.crt ]  && cp /openvpn/ca.rsa.2048.crt  /config/openvpn/

sed -i -e "s/^remote .*$/remote $VPN_REMOTE $VPN_REMOTE_PORT/" /config/openvpn/openvpn.ovpn
sed -i -e 's/^auth-user-pass.*$/auth-user-pass \/config\/openvpn\/login.conf/' /config/openvpn/openvpn.ovpn

cat <<EOF > /config/openvpn/login.conf
${VPN_USERNAME}
${VPN_PASSWORD}
EOF
