# Set global $CONFIG_FILE and include it

function read_config_file() {
	CONFIG_FILE="$1"
	if [ -f "$CONFIG_FILE" ]; then
		source "$CONFIG_FILE"
	else
		echo "Cannot read config file '$CONFIG_FILE'."
		return 1
	fi
	return 0
}

function create_config_file() {
	CONFIG_FILE="$1"
	if [ -f "$CONFIG_FILE" ]; then
		echo "Config file already exists"
		return 2
	fi
	CONFIG_DIR="$(dirname "$CONFIG_FILE")"
	if [ ! -d "$CONFIG_DIR" ]; then
		mkdir "$CONFIG_DIR" # Optional -p ?
	fi
	touch "$CONFIG_FILE"
	return $?
}
