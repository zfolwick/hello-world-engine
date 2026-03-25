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
  local EXTENSION="$1"
  [[ "${FILENAME%*.$EXTENSION}" != "${FILENAME}" ]] && echo "$FILENAME" || echo "$FILENAME".$EXTENSION
}

helloworld() {
  local FILE
  FILE=$(set_filename "$1")
  cat "$PWD"/lib/"$2".hw > "$FILE"
  chmod +x "$FILE"
}


while [ "$#" -gt 0 ]; do
  case "$1" in
    bash)
      shift
      helloworld "sh" "bash"
      exit $?
      ;;
    c)
      shift
      helloworld "c" "c"
      exit $?
      ;;
    cpp|c++)
      shift
      helloworld "cpp" "cpp"
      exit $?
      ;;
    go)
      shift
      helloworld "go" "go"
      exit $?
      ;;
    node)
      shift
      helloworld "js" "node"
      exit $?
      ;;
    python)
      shift
      helloworld "py" "python"
      exit $?
      ;;
    ts)
      shift
      helloworld "ts" "typescript"
      exit $?
      ;;
    -h|--help|help)
      description
      usage
      hw_help
      exit 0
      ;;
      *)
      echo "unknown command: [$1]" 
      description
      usage
      hw_help
      exit 1
      ;;
  esac
done
