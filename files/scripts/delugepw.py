#!/usr/bin/env python
# Changes the password for Deluge's Web UI

from deluge.config import Config
import hashlib
import os.path
import sys
import os

print(os.environ['HOME'])

config = Config("web.conf", config_dir="/config")
password = os.environ['DELUGE_PASSWORD']
s = hashlib.sha1()
s.update(config['pwd_salt'])
s.update(password)
config['pwd_sha1'] = s.hexdigest()

try:
  config.save()
except IOError, e:
  print "Couldn't save password: ", e
else:
  print "Password successfully set!"
