#!/bin/sh

makedir() {
  [ ! -d "$1" ] && mkdir -p --mode 0775 "$1"
}

makedir $TORRENTS_DIR
makedir $AUTOADD_LOCATION
makedir $DOWNLOAD_LOCATION
makedir $MOVE_COMPLETED_PATH
makedir $PLUGINS_LOCATION
makedir $TORRENTFILES_LOCATION
