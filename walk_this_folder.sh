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
		elif [[ "${BASH_SOURCE}~" -ef "${object}" ]]; then
			continue
    elif [[ "${object}" = '.' || "${object}" = '..' ]]; then
      continue
		elif [[ "${object}" -ef 'README.md' ]]; then
			continue
		fi

		local continue_set=0
		while read line; do
			if [[ "${object}" =~ ^$line$ ]]; then
				continue_set=1
				break
			fi
		done < "${BASH_SOURCE%/*}/.gitignore"

		if [[ ${continue_set} -eq 1 ]]; then
			continue
		fi


    if [[ -d "${object}" ]]; then
      walk_and_source "${object}"
      continue
    else
      . "${object}"
      continue
    fi
  done
}

walk_and_source "${HOME}/.bash/"
