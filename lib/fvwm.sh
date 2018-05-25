
# Exits when no fvwm2 process found.
function require_fvwm2 () {
	ps ax |awk '{print $5;}' |grep fvwm2 >/dev/null
	local FVWM_RUNNING=$?
	if [ 0 -ne $FVWM_RUNNING ]; then
	 exit $?
	fi
}

# Set wallpaper in Fvwm
# $1 Filename of wallpaper image.
function fvwm_set_wall () {
  local WALL="$1"
  if test -f "$WALL"; then
    FvwmCommand "Wallpaper-Set $WALL"
  else 
    echo "File '$WALL' not found"
  fi
}
