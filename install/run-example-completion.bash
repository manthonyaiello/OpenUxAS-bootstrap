#! /usr/bin/env bash

# This completion works for zsh (even though the script says "bash" in the
# file extension), but we have to find the script directory differently.
if [ $ZSH_VERSION ]; then
  INSTALL_DIR=${0:a:h}
else
  # Assume bash. (Could test with $BASH_VERSION, but we don't have a fallback
  # plan.)
  INSTALL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi

_run_example_completions() {
  _OPTIONS="$( ${INSTALL_DIR}/../run-example --complete-options )"
  if [ $? != 0 ]; then
    COMPREPLY=("Autocomplete not available; build OpenUxAS using \`./anod build uxas\`" " ")
  else
    COMPREPLY=( $( compgen -W "${_OPTIONS}" -- "${COMP_WORDS[1]}" ) )
  fi
}

complete -F _run_example_completions run-example
