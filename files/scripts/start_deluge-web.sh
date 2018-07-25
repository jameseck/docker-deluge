#!/bin/sh

COUNTER=0
TRIES=10

until ss -lptn 'sport = :58846' | grep 58846 > /dev/null 2>&1 || [ $COUNTER -eq $TRIES ]; do
   sleep $(( COUNTER++ ))
done

if [ $COUNTER -eq $TRIES ]; then
  echo "Deluge daemon was not accessible."
  exit 1
fi

/usr/bin/deluge-web -c /config -L $LOGLEVEL -l /dev/stderr
