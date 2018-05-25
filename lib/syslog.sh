# Shared syslog functions 
# Following syntax/parameters of other languages.

SYSLOG_IDENT="$USER"
SYSLOG_FACILITY="local0"

function openlog() {
	if [ $# -ne 3 ]; then 
		echo "Usage: openlog ident option[,option,...] facility" >&2 
		return 1
	fi
	SYSLOG_IDENT="$1"
	SYSLOG_OPTIONS="$2"
	SYSLOG_FACILITY="$3"
	case ",$2," in
		",pid,") 
			SYSLOG_IDENT="$1[$$]"
			;;
	esac
	return 0
}

function syslog() {
	if [ $# -lt 2 ]; then 
		echo "Usage: syslog [facility.]priority format ..." >&2 
		return 1
	fi
	local FORMAT="$2"
	case "$1" in
		*.*) SYSLOG_PRIORITY="$1";;
		*)   SYSLOG_PRIORITY="$SYSLOG_FACILITY.$1"
	esac
	shift 2
	printf "$FORMAT" "$@" | logger -t "$SYSLOG_IDENT" -p "$SYSLOG_PRIORITY"
	return 0
}

function closelog() {
	SYSLOG_IDENT="$USER"
	SYSLOG_FACILITY="local0"
}


