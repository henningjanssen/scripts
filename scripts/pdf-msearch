#!/bin/bash

function help {
  echo "Usage:"
  echo -e " in CWD:\tpdf-msearch.sh pattern"
  echo -e " explicit path:\tpdf-msearch.sh relpath pattern"
  echo -e " \t\tpdf-msearch.sh /abspath pattern"
  echo -e " display help:\tpdf-msearch --help"
}

if [ "$*" == "" ]; then
  echo "No parameter defined"
  help
  exit 1
fi

if [ "$*" == "--help" ]; then
  help
  exit 0
fi

PATTERN=""
SPATH=$(pwd)

if [[ $# > 1 ]]; then
  SPATH=$1
  shift
fi

PATTERN="$*"

echo "Searching for '$PATTERN'"
echo "Searching in '$SPATH'"

FILTER='pdftotext "{}" - | grep -i --with-filename --label="{}" --color "'
FILTER="$FILTER$PATTERN"
FILTER="$FILTER\""

find "$SPATH" -name '*.pdf' -exec sh -c "$FILTER" \;
