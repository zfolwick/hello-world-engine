#!/usr/bin/env bash

description() {
  echo "Creates a simple hello world program in a target language."
}

usage() {
  cat << USE
  Usage:
  "$0" LANGUAGE

  Example:
  "$0 go

  Outputs "helloworld.go"


USE
}

hw_help() {
  local integrations_list
  integrations_list=$(ls $PWD/lib | awk '{sub(/.hw/,""); print}')
  cat "$PWD"/lib/help.txt

  printf "%s\n" "$integrations_list"
  echo ""
}

[[ "$#" == 0 ]] && { 
  echo "Need language" && usage && hw_help && exit 1
}

set_filename() {
  local FILENAME="helloworld"
  local EXTENSION
  EXTENSION=$(sed -n '2p' "$PWD"/lib/"$1".hw | cut -d':' -f 2 | tr -d ' ')
  [[ "${FILENAME%*.$EXTENSION}" != "${FILENAME}" ]] && echo "$FILENAME" || echo "$FILENAME".$EXTENSION
}

helloworld() {
  local FILE
  local LANGUAGE_BINDING="$1"
  FILE=$(set_filename "$LANGUAGE_BINDING")
  cat "$PWD"/lib/"$LANGUAGE_BINDING".hw > "$FILE"
  chmod +x "$FILE"
  exit 0
}

if [[ "$1" == *"-h" || "$1" == *"help" ]]; then
  description
  usage
  hw_help
  exit 0
fi

LANGUAGE_BINDING="$1"
helloworld "$LANGUAGE_BINDING"

