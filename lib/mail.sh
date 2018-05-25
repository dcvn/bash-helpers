# mail functions 

declare MAILSERVER_FQDN="localhost"
declare MAIL_DEFAULT_TO="root@localhost"
declare MAILBODY_PLAIN
declare MAILBODY_HTML


function mail_image_att ()
{
	echo "$BODY" | mutt -s "$SUBJECT" -a "$FILE"  -- "$MAILTO"
}


# mail_image_inline $FILENAME $SUBJECT $MAILTO
function mail_mime_image_inline ()
{
	local FILENAME="$1"
	local SUBJECT="$2"
	local MAIL_TO="${3:-$MAIL_DEFAULT_TO}"
	local MAIL_TO_NAME="${4:-$MAIL_TO}"
	local BOUNDARY="_bnd_$(date +%s)_"
	local CONTENT_ID="$(basename $FILENAME)"

	local CONTENT_TEXT=""
	local CONTENT_PLAIN=${MAILBODY_PLAIN:-""}
	local CONTENT_HTML=${MAILBODY_HTML:-""}
	if [ "" != "$CONTENT_HTML" ]; then 
		CONTENT_TEXT="$CONTENT_HTML"
	else
		CONTENT_TEXT="<pre>$CONTENT_PLAIN</pre>"
	fi
	local SYSHOST=$(hostname)
	local SYSUSER=$(id -un)
	local SYSGECOS=$(getent passwd $(id -un) |cut -d: -f5 |cut -d, -f1)

	echo "From: (${MAIL_FROM_NAME:-$SYSGECOS}) <${MAIL_FROM:-$SYSUSER@$SYSHOST}>
To: (${MAIL_TO_NAME:-$MAIL_TO}) <${MAIL_TO}>
Subject: ${SUBJECT}
Date: $(date -R)
MIME-Version: 1.0
Content-Type: multipart/related; boundary=\"${BOUNDARY}\"

--${BOUNDARY}
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
 <p><img src=\"cid:${CONTENT_ID}\"></p>
 ${CONTENT_TEXT}
</html>

--${BOUNDARY}
Content-Type: $(file -b --mime-type ${FILENAME})
Content-Transfer-Encoding: base64
Content-Description: $(basename ${FILENAME})
Content-ID: <${CONTENT_ID}>
Content-Disposition: inline; filename=\"$(basename ${FILENAME})\"; 

$(base64 $FILENAME)

--${BOUNDARY}--

"

}

# mail_send_tcp $MAIL_TO $MAIL_FROM < $RFC822FILE
# mail_mime_image_inline $@ | mail_send_tcp $MAIL_TO $MAIL_FROM
# mail_mime_image_attach $@ | mail_send_tcp $MAIL_TO $MAIL_FROM
function mail_send_tcp ()
{
	# Config 
	SERVER="$MAILSERVER_FQDN" 
	PORT=25
	DEFAULT_FROM="${USER}@$(hostname)"
	RCPT_TO=${1:-$MAIL_DEFAULT_TO}
	MAIL_FROM=${2:-$DEFAULT_FROM}
	SMTP_DATA="" # read stdin
	
	exec 3<>/dev/tcp/${SERVER}/${PORT} 
	#cat <&3 
	echo "MAIL FROM: ${MAIL_FROM}" >&3 
	#cat <&3 
	echo "RCPT TO: ${RCPT_TO}" >&3 
	#cat <&3 
	echo "DATA" >&3 
	#cat <&3 
	while read LINE ; do
		echo "$LINE" >&3 
	done
	echo "." >&3 
	#cat <&3 
	echo "QUIT" >&3 
	cat <&3 
	
}



# TODO: merge _inline & _attach.
# mail_image_inline $FILENAME $SUBJECT $MAILTO
function mail_mime_image_attach ()
{
	local FILENAME="$1"
	local SUBJECT="$2"
	local MAIL_TO="${3:-$MAIL_DEFAULT_TO}"
	local MAIL_TO_NAME="${4:-$MAIL_TO}"
	local BOUNDARY="_bnd_$(date +%s)_"
	local CONTENT_ID="$(basename $FILENAME)"

	local CONTENT_TEXT=""
	local CONTENT_PLAIN=${MAILBODY_PLAIN:-""}
	local CONTENT_HTML=${MAILBODY_HTML:-""}
	if [ "" != "$CONTENT_HTML" ]; then 
		CONTENT_TEXT="$CONTENT_HTML"
	else
		CONTENT_TEXT="<pre>$CONTENT_PLAIN</pre>"
	fi
	local SYSHOST=$(hostname)
	local SYSUSER=$(id -un)
	local SYSGECOS=$(getent passwd $(id -un) |cut -d: -f5 |cut -d, -f1)

	echo "From: (${MAIL_FROM_NAME:-$SYSGECOS}) <${MAIL_FROM:-$SYSUSER@$SYSHOST}>
To: (${MAIL_TO_NAME:-$MAIL_TO}) <${MAIL_TO}>
Subject: ${SUBJECT}
Date: $(date -R)
MIME-Version: 1.0
Content-Type: multipart/related; boundary=\"${BOUNDARY}\"

--${BOUNDARY}
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
 ${CONTENT_TEXT}
</html>

--${BOUNDARY}
Content-Type: $(file -b --mime-type ${FILENAME})
Content-Transfer-Encoding: base64
Content-Description: $(basename ${FILENAME})
Content-ID: <${CONTENT_ID}>
Content-Disposition: attachment; filename=\"$(basename ${FILENAME})\"; 

$(base64 $FILENAME)

--${BOUNDARY}--

"

}
