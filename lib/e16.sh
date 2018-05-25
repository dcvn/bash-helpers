# Shared functions for Enlightenment DR16 environment.

function require_e16 () {
	# Only continue when Enlightenment is running. 
	local E_RUNNING=$(ps ax|grep 'e16'|grep -v grep |wc -l)
	if test $E_RUNNING == 0 ; then
		exit 1
	fi
}

# Usage: e16_setbackground 2 "$HOME/img/wall.jpg" [ "RNDWALL_" ] [ "255 128 161" ]
# Todo: support foreground image 
function e16_setbackground () {
	if [ "" != "$1" ]; then
		E16_DESK="$1"
	elif [ "" == "$E16_DESK" ]; then
		E16_DESK=1
	fi
	
	if [ "" != "$2" -a -f "$2" ]; then
		E16_BGFILE="$2"
	elif [ "" == "$E16_BGFILE" -o ! -f "$E16_BGFILE" ]; then
		print_log "No usable BGFILE found."
		E16_BGFILE=""
	fi
	
	if [ "" != "$E16_BGFILE" ]; then
		if [ "" != "$3" ]; then
			E16_BGNAME="$3$E16_DESK"
		else
			E16_BGNAME="E16_DESK_$E16_DESK"
		fi
		if [ "" != "$4" ]; then
			E16_BGCOLOR="$4"
		else
			E16_BGCOLOR="255 128 128"
		fi
		eesh bg del $E16_BGNAME 
		eesh bg load $E16_BGNAME "$E16_BGFILE"
		eesh bg set $E16_BGNAME bg.keep_aspect 1
		eesh bg set $E16_BGNAME bg.solid $E16_BGCOLOR

		# Todo: make common (Not TMPDIR/BASENAME)
		if [ "$MAKETRANSFG" -eq 1 ]
		then
			# xperc,yperc,xjust,yjust: 1024,1024,400,0
			# 730/1050*1024=712
			eesh bg set $E16_BGNAME top.file "$TMPDIR/$BASENAME.trans.png"
			eesh bg set $E16_BGNAME top.keep_aspect 1
			eesh bg set $E16_BGNAME top.xperc 1024
			eesh bg set $E16_BGNAME top.yperc 640
			eesh bg set $E16_BGNAME top.xjust 256
			eesh bg set $E16_BGNAME top.yjust 128
		fi

		eesh bg use $E16_BGNAME $E16_DESK
	fi
}

