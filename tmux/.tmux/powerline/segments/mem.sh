# Print out mem using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	type tmux-mem-cpu-load >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	stats=$(tmux-mem-cpu-load --mem_only)
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0
}
