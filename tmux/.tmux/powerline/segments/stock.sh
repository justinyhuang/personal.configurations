# Prints the quote of the specified company stock

generate_segmentrc() {
	read -d '' rccontents  << EORC
EORC
	echo "$rccontents"
}

run_segment() {
	local stock
        stock="$(~/bin/ticker.sh FB QQQ SPY ARKK)"
        echo "${stock}"
        #echo "stock"
        return 0
}
