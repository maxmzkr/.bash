#!/bin/bash
#
# adds the ~/bin folder to the users path

if [[ -d "${HOME}/.bin" ]]; then
  PATH="${HOME}/.bin:${PATH}"
fi
