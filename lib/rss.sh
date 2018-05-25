# Common function related to RSS reading

function rss_num_items () {
	local RSSFILE="$1"
	RSS_NUM_ITEMS=$(xmlstarlet sel -t -v 'count(/rss/channel/item)' $RSSFILE)
}

function rss_read_item () {
	local RSSFILE="$1"
	local RSSITEM="$2"
	RSS_TITLE=$(xmlstarlet sel -T -t -v /rss/channel/item[$RSSITEM]/title $RSSFILE)
	RSS_LINK=$(xmlstarlet sel -T -t -v /rss/channel/item[$RSSITEM]/link $RSSFILE)
	RSS_DESCRIPTION=$(xmlstarlet sel -T -t -v /rss/channel/item[$RSSITEM]/description $RSSFILE)
	RSS_PUBDATE=$(xmlstarlet sel -T -t -v /rss/channel/item[$RSSITEM]/pubDate $RSSFILE)
	
}

function rdf_num_items () {
	local RSSFILE="$1"
	echo "Counting..."
	RSS_NUM_ITEMS=$(xmlstarlet sel -N o="http://purl.org/rss/1.0/" -N rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" -t -v 'count(/rdf:RDF/o:item)' $RSSFILE)
	echo "Counted $RSS_NUM_ITEMS"
}

function rdf_read_item () {
	local RSSFILE="$1"
	local RSSITEM="$2"
	RSS_TITLE=$(xmlstarlet sel  -N o="http://purl.org/rss/1.0/" -N rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" -T -t -v /rdf:RDF/o:item[$RSSITEM]/o:title $RSSFILE)
	RSS_LINK=$(xmlstarlet sel  -N o="http://purl.org/rss/1.0/" -N rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" -T -t -v /rdf:RDF/o:item[$RSSITEM]/o:link $RSSFILE)
	RSS_DESCRIPTION=$(xmlstarlet sel -N o="http://purl.org/rss/1.0/" -N rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" -T -t -v /rdf:RDF/o:item[$RSSITEM]/o:description $RSSFILE)
	#RSS_PUBDATE=$(xmlstarlet sel -T -t -v /rdf/item[$RSSITEM]/pubDate $RSSFILE)
	
}

# Set global RSS_DIR, RSS_FILE variables.
function rss_set_file() {
	local TMPNAME="$1"
	RSS_DIR=$HOME/tmp/feeds/$TMPNAME
	if [ ! -d $RSS_DIR ]; then
		mkdir -p $RSS_DIR
	fi
	RSS_FILE=$RSS_DIR/rss.xml
	rm -f $RSS_FILE
}
