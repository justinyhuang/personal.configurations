# Print out cpu using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	#type tmux-mem-cpu-load >/dev/null 2>&1
	#if [ "$?" -ne 0 ]; then
	#	return
	#fi

	stats=$(tmux-mem-cpu-load)
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0

        #line=`head /proc/stat --line=1`
        #current_user=`echo $line|cut -d " " -f 2`
        #current_system=`echo $line|cut -d " " -f 3`
        #current_nice=`echo $line|cut -d " " -f 4`
        #current_idle=`echo $line|cut -d " " -f 5`
        #
        #file=/tmp/cpu.load.previous
        #`touch $file`
        #previous_user=`cat $file|cut -d " " -f 1`
        #previous_system=`cat $file|cut -d " " -f 2`
        #previous_nice=`cat $file|cut -d " " -f 3`
        #previous_idle=`cat $file|cut -d " " -f 4`
        #
        #`echo $current_user $current_system $current_nice $current_idle > $file`
        #load=$(echo "$current_user+$current_system+$current_nice-$previous_user-$previous_system-$previous_nice" | bc)
        #all=$(echo "$load+$current_idle-$previous_idle" | bc)
        #ratio=$(echo "scale=2;$load/$all" | bc)

        #echo "CPU[$load, $all, $ratio]"
}
