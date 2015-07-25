#!/bin/sh

for f in $(find /home/share/tv/tmp -maxdepth 1 -mtime +10 -type f); do
  if [ $(basename $f) != ".DS_Store" ]; then
    rm -Rf ${f}
  fi
done