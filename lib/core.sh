# Core functions:
# Used for other functions in the shared library.

# Let the script die if a command is not found.
# Only `which` should be available...
# Example: require_commands tar ls gzip 
function require_commands () {
  local ERR=0
  local MISSING=()
  for CMD in "$@" ; do
    if ! which $CMD > /dev/null ; then
      ERR=1
      MISSING+=($CMD)
    fi
  done
  if [ $ERR -gt 0 ]; then
    echo "Some commands not found in your PATH, exiting." >&2
    echo "Please check install or path for: ${MISSING[*]}"
    exit 1
  fi
}


# Prints "1680x1050"
#require_commands xrandr awk grep
function get_screen_size () {
	xrandr | grep '*' | awk '{print $1;}'
}
