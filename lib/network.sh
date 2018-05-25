#  Network related functions for in scripts

# What is my external ip address?
function my_ext_ip () {
	local FILE=~/.my_ext_ip.txt
	local URL="http://ipecho.net/plain"
	#if file is not recent; then
	wget -q -O $FILE "$URL"
	#fi
	cat $FILE
}
