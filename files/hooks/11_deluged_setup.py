#!/usr/bin/env python

import os
import deluge.common
import logging, sys
from deluge.configmanager import ConfigManager, get_config_dir, set_config_dir

logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

def get_env_or_default(var, default):
  v = os.environ.get(var)
  if v:
    return v
  else:
    return default

def str2bool(v):
  return v.lower() in ("yes", "true", "t", "1")

config_dir = get_env_or_default('CONFIG_DIR', '/config')
torrents_dir = get_env_or_default('TORRENTS_DIR', '/torrents')
listen_ports = map(int, get_env_or_default('LISTEN_PORTS', '6881,6881').split(','))
daemon_port = int(get_env_or_default('DAEMON_PORT', 58846))
random_port = str2bool(get_env_or_default('RANDOM_PORT', False))
upnp = str2bool(get_env_or_default('UPNP', False))

geoip_db_location = get_env_or_default('GEOIP_DB_LOCATION', config_dir + '/GeoIP/GeoIP.dat')
plugins_location = get_env_or_default('PLUGINS_LOCATION', config_dir + '/deluge/plugins')

move_completed_path = get_env_or_default('MOVE_COMPLETED_PATH', torrents_dir + '/completed')
torrentfiles_location = get_env_or_default('TORRENTFILES_LOCATION', torrents_dir + '/.torrents')
download_location = get_env_or_default('DOWNLOAD_LOCATION', torrents_dir + '/.in_progress')
autoadd_location = get_env_or_default('AUTOADD_LOCATION', torrents_dir + '/.drop')

if not os.path.exists(config_dir):
  os.makedirs(config_dir)

set_config_dir(config_dir)
config = ConfigManager(config_dir + '/core.conf')

config['move_completed_path'] = move_completed_path
config['torrentfiles_location'] = torrentfiles_location
config['download_location'] = download_location
config['autoadd_location'] = autoadd_location
config['geoip_db_location'] = geoip_db_location
config['plugins_location'] = plugins_location

config['listen_ports'] = listen_ports
config['daemon_port'] = daemon_port
config['random_port'] = random_port

config.save()
