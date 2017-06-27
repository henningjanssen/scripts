#!/usr/bin/env bash

#colors
GREEN="\e[0;32m"
RED="\e[0;31m"
NOCOLOR="\e[00m"

PREV_RM=true
ALL_MEDIA=false

for var in "$@"
do
  case "$var" in
    --no-rm)
      PREV_RM=false
      printf "Not removing destiny-dir before creating backup\n"
      ;;
    --all-media)
      ALL_MEDIA=true
      printf "Backing up to all media-devices\n"
      ;;
  esac
done

backup(){
  printf "Checking for "
  BPATH=$1
  if [[ $1 != /* ]]; then
    BPATH="/media/$USER/$1"
    printf "$1 (media): "
  else
    printf "${BPATH}: "
  fi
  if [[ $BPATH != */ ]]; then
    BPATH="${BPATH}/"
  fi
  if [ "$DIR" == "${BPATH}${DIRNAME}" ]; then
    printf "${RED}this directory${NOCOLOR}\n"
    return 1
  fi
  if [ -d "${BPATH}" ]; then
    printf "${GREEN}found${NOCOLOR}\n"
    if [ "$PREV_RM" = true ]; then
      printf "  rm ${BPATH}${DIRNAME} ..."
      rm -rf "${BPATH}${DIRNAME}"
      printf "${GREEN} done.${NOCOLOR}\n"
    fi
    printf "  cp to ${BPATH} ..."
    cp "$DIR" "${BPATH}" -Rf
    if [ $? == 0 ]; then
      printf "${GREEN} done.${NOCOLOR}\n"
    else
      printf "${RED} ERROR! (Code $?)${NOCOLOR}\n"
    fi
  else
    printf "${RED}not found${NOCOLOR}\n"
  fi
}

function iterateMedia(){
  filter=false
  if [ "${1+set}" ]; then
    filter=true
  fi
  for d in /media/$USER/*/ ; do
    if [ "$ALL_MEDIA" = true ] || [ "$filter" = false ] || [[ $d == /media/$USER/$1* ]] ; then
      backup "$d"
    fi
  done
}

# From https://stackoverflow.com/a/246128
SOURCE="${BASH_SOURCE[0]}"
printf "BASH_SOURCE: $SOURCE\n"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
# END

DIRNAME="$(basename "$DIR")"
printf "Directory name: $DIRNAME\n"

printf "Resolved source: $DIR\n"

iterateMedia "HJ"
backup "/home/$USER/sciebo"
