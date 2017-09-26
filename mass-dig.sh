#!/bin/bash

PARALLEL=25

dig_host () {
  if [ -z "$1" ]; then
    echo "[!] invalid args for dig_host"
    exit 1
  fi
  host=$1

  echo "[*] digging host $host"
  res=$(dig "$host" ANY +noall +answer | grep -v "^;" | grep -v "^$")
  if [ -z "$res" ]; then
    echo "[*] result for host $host was empty"
  else
    echo "[*] result found for host $host"
    echo "$res" > "${host}.dug"
    echo "$host" >> "found_hosts.dug"
  fi
}

export -f dig_host

if [ -z "$1" ]; then
  echo "[!] usage: $0 [FILE]";
  exit 1;
fi

if [ -z "$2" ]; then
  PARALLEL="$2"
fi

if [ ! -f "$1" ]; then
  echo "[!] error: $1 is not a file"
  exit 1
fi

file=$1

echo "[*] scanning domains from $file en masse"
cat $file | xargs -P $PARALLEL -I {} bash -c 'dig_host "$@"' _ {}
