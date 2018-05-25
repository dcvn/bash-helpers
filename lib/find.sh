# Common functions about finding files.

# $1 Main MIME type (image, text, application)
# $2 Directory for 'find'
# @ 'find' output 
function find_mime_files () {
  local MIMEMAIN="$1" # only main
  local DIR="$2"
  shift 2
  local EXTRA_ARGS=("$@") 
  BASH_CMD='file -F":::" -i "{}" |egrep ":::\s+'$MIMEMAIN'/[a-zA-Z0-9_.-]+" >/dev/null 2>&1 '
  find "$DIR" "${EXTRA_ARGS[@]}" -type f -exec bash -c "$BASH_CMD" \; -print
}

# Stdin: lines to be randomized in order.
# Should be less then 1000 lines...
function sort_random () {
	local -i SHUFNUM=${1:-1000}
	while read x; do 
        echo "`expr $RANDOM % $SHUFNUM`:$x"
    done | sort -n | sed 's/[0-9]*://' 
}

# attempt to make func from "randomwall-e16/common"  more generic ....  WiP
function find_random_image_files_X () {
	local DIR="$1"
	local DEPTH="$2"
	local NAME="$3"
	find_mime_files image "$DIR" -maxdepth $DEPTH -ipath "*$NAME*"\
		-ctime +$MIN_AGE -ctime -$MAX_AGE
	# sort_random & head-n should be outside
}
