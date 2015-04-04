#!/bin/bash
#
# Adds the git branch to the terminal's prompt

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(parse_git_branch)$ "
