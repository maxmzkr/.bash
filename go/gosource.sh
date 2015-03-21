#!/bin/bash
#
# Takes the current path and makes it the gopath

gosource() {
  if [[ "${GOPATH}" ]]; then
    echo "removing ${GOPATH} from the environment"
  fi
  export GOPATH="$(readlink -f $1)"
  echo "GOPATH is now ${GOPATH}"
}

export GOPATH="/home/max/gopath"
