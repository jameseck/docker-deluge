#!/usr/bin/env python

import os
from distutils.dir_util import copy_tree

initial_config = '/config_initial'

config_dir = os.environ.get('CONFIG_DIR')

if not os.listdir(config_dir):
  print "Seeding config from default"
  copy_tree(initial_config, config_dir)
  os.mkdir("%s/state" % config_dir)
