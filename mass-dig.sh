#!/bin/bash

PARALLEL=25

dig_host () {
  if [ -z "$1" ]; then
    echo "[!] invalid args for dig_host"
    exit 1
  fi
  host=$1

  res=$(dig "$host" +short | tr '\n' , 2> /dev/null)
  res=${res%?};
  if [[ $res == *"connection timed out"* ]] || [ -z "$res" ]; then 
    return
  else  
    echo "$host : $res"
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

cat $file | xargs -P $PARALLEL -I {} bash -c 'dig_host "$@"' _ {}
