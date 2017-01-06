#!/usr/bin/env python

import os
import hashlib
import random
import deluge.common
import logging, sys
from deluge.config import Config

logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

def get_env_or_default(var, default):
  v = os.environ.get(var)
  if v:
    return v
  else:
    return default

config_dir = get_env_or_default('CONFIG_DIR', '/config')
web_port = int(get_env_or_default('WEB_PORT', 8112))
password = get_env_or_default('DELUGE_PASSWORD', 'deluge')
daemon_port = int(get_env_or_default('DAEMON_PORT', 58846))

config = Config("web.conf", config_dir=config_dir)

config['default_daemon'] = '127.0.0.1:%d' % daemon_port
config['port'] = web_port

salt = hashlib.sha1(str(random.getrandbits(40))).hexdigest()
s = hashlib.sha1(salt)

config['pwd_salt'] = salt
s.update(password)
config['pwd_sha1'] = s.hexdigest()

try:
  config.save()
except IOError, e:
  print "Couldn't save new password: ", e
  sys.exit(1)
