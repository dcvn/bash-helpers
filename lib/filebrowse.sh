# Shared functions: file selection / browsing / search?

function select_file () {
	local DIR="$1"
	cd $DIR
	select f in .* * ; do
		if test -n "$f" ; then
			if test -d "$f" ; then
				cd "$f"
				select_file "$f"
				echo "recurselect: $FILE"
				cd ..
			fi
			break
		fi
		echo "! Kies een nummer uit de lijst."
	done
	FILE=$(basename $f)
	cd - >/dev/null
}


function cdfavo () {
	local CDFAVO_FILE=~/etc/cdfavo
	select d in $(cat $CDFAVO_FILE); do
	    test -n "$d" && break
	done
	if [ -d "$d" ]; then
		cd "$d"
	fi
}

