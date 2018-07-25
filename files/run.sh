#!/bin/bash

set -e

[ ! -f /config/core.conf ] && cp /config_initial/core.conf /config/
[ ! -f /config/web.conf ] && cp /config_initial/web.conf /config/

python /scripts/delugepw.py

if [ "${DEBUG}" == "true" ]; then
  export LOGLEVEL=debug
else
  export LOGLEVEL=info
fi

if [ "$1" == "" ]; then
  exec supervisord -nc /etc/supervisord.conf
fi

exec "$@"
