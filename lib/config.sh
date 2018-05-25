# Set global $CONFIG_FILE and include it

function read_config_file() {
    CONFIG_ARG=${1:-config}
    local CONFIG_FILE=$(find_config_file $CONFIG_ARG $2)
    if [ "$CONFIG_FILE" = "" ]; then
        echo "Cannot read config file '$CONFIG_ARG'." >&2
        return 1
    fi
    source $CONFIG_FILE
    
    return 0
}

function find_config_file() {
    local CONFIG_FILE=${1:-config}
    local CONFIG_DIR=$2
    if [ -f "$CONFIG_FILE" ]; then
        echo "$CONFIG_FILE"
    elif [ -f "$CONFIG_DIR/$CONFIG_FILE" ]; then
        echo "$CONFIG_DIR/$CONFIG_FILE"
    elif [ -f "$HOME/.config/$APPNAME/$CONFIG_FILE" ]; then
        echo "$HOME/.config/$APPNAME/$CONFIG_FILE"
    else
        return 1
    fi
    return 0
}

function create_config_file() {
    local CONFIG_FILE=$(find_config_file $1 $2)
    if [ -f "$CONFIG_FILE" ]; then
        echo "Config file already exists" >&2
        return 2
    fi
    
    local CONFIG_FILE=$(basename ${1:-config})
    local CONFIG_DIR
    if [ -d "$2" ]; then
        CONFIG_DIR="$2"
    elif [ "" != "$APPNAME" ]; then
        CONFIG_DIR="$HOME/.config/$APPNAME"
        if [ ! -d $CONFIG_DIR ]; then
            mkdir -p "$CONFIG_DIR"
            echo "Created config directory: $CONFIG_DIR" >&2
        fi
    else
        echo "Cannot determine APPNAME" >&2
        return 1
    fi
    
    touch $CONFIG_DIR/$CONFIG_FILE
    echo $CONFIG_DIR/$CONFIG_FILE

    # while read LINE ; do
    #    echo "$LINE" >> $CONFIG_DIR/$CONFIG_FILE
    # done
        
    return $?
}
