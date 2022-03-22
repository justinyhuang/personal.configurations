# Prints the current weather in Celsius, Fahrenheits or lord Kelvins. The forecast is cached and updated with a period of $update_period.

generate_segmentrc() {
	read -d '' rccontents  << EORC
EORC
	echo "$rccontents"
}

run_segment() {
	local tmp_file="${TMUX_POWERLINE_DIR_TEMPORARY}/weather.txt"
	local weather
        weather=$(cat "${tmp_file}")
        echo "$weather"
        #echo "weather"
}
