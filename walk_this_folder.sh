#!/bin/bash
#
# Walk the directory and source it

#######################################
# Walk the directory and perform the source command on each file
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
walk_and_source() {
  local directory="$1"
  if [[ -z "${directory}"  ]]; then
    directory="."
  fi
  
  local directory_list=("${directory}"/*)

  for object in "${directory_list[@]}"; do
    if [[ "${BASH_SOURCE}" -ef "${object}" ]]; then
      continue
    elif [[ "${object}" = '.' || "${object}" = '..' ]]; then
      continue
    elif [[ -d "${object}" ]]; then
      walk_and_source "${object}"
      continue
    else
      . "${object}"
      continue
    fi
  done
}

walk_and_source "${HOME}/.bash/"
