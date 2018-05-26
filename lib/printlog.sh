# Shared print/log functions 
declare -i VERBOSE=0
declare -i QUIET=0

PRINTLOG_DATEFORMAT='%Y-%m-%d %H:%M:%S'

if [ "$APPNAME" = "" ]; then
  APPNAME="shellscript"
fi

function print_log () {
  local TIME=$(date +"$PRINTLOG_DATEFORMAT")
  echo "[$TIME] $*"
}

function print_verbose () {
  if [ "$VERBOSE" -gt 0 ]; then
    if [ "$1" == "log" ]; then
      shift 1
      print_log "$*"
    else
      echo "$*"
    fi
  fi
}

function print_noquiet () {
  if [ "$QUIET" -eq 0 ]; then
    if [ "$1" == "log" ]; then
      shift 1
      print_log "$*"
    else
      echo "$*"
    fi
  fi
}

function print_app_log() {
  local TIME=$(date +"$PRINTLOG_DATEFORMAT")
  echo "[$TIME] $APPNAME: $*"
}

function print_app_verbose() {
  if [ "$VERBOSE" -gt 0 ]; then
    local TIME=$(date +"$PRINTLOG_DATEFORMAT")
    echo "[$TIME] $APPNAME: $*"
  fi
}
