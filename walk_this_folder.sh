#!/bin/bash
#
# Walk the directory and source it

#######################################
# Walk the directory and perform the source command on each file
# Globals:
#   None
# Arguments:
#   Folder to walk
# Returns:
#   None
#######################################
walk_and_source() {
  local directory="$1"
  if [[ -z "${directory}"  ]]; then
    directory="."
  fi
  
  local directory_list=("${directory}"/*)
	local hidden_directory_list=("${directory}"/.*)
	directory_list=("${directory_list[@]}" "${hidden_directory_list[@]}")

  for object in "${directory_list[@]}"; do
		local filename="${object##*/}"
		echo "${object}"
    if [[ "${BASH_SOURCE}" -ef "${object}" ]]; then
      continue
		elif [[ "${BASH_SOURCE}~" -ef "${object}" ]]; then
			continue
		elif [[ "${BASH_SOURCE%/*}/.git" -ef "${object}" ]]; then
			continue
    elif [[ "${filename}" = '.' || "${filename}" = '..' ]]; then
      continue
		elif [[ "${filename}" = 'README.md' ]]; then
			echo "match"
			continue
		elif [[ "${filename}" = '.gitignore' ]]; then
			echo "match"
			continue
		fi

		local continue_set=0
		while read line; do
			grep -q -E "${line}" <<< ${object}
			local grep_found="${?}"
			if [[ "${grep_found}" -eq 0 ]]; then
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
