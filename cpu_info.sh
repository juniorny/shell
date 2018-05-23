#!/bin/bash

while true
do
	info1=`awk 'NR==1 {for(i=2;i<=NF;i++) sum+=$i} NR==1 {printf "%d ", $5} END{print (sum+0)}' /proc/stat`
	sleep 1s
	info2=`awk 'NR==1 {for(i=2;i<=NF;i++) sum+=$i} NR==1 {printf "%d ", $5} END{print (sum+0)}' /proc/stat`
	cpu_usage=`echo "$info1 $info2" | awk '{printf("cpu_usage = %.2f%%\n", ($4-$2-($3-$1))/($4-$2)*100)}'`
	echo $cpu_usage
done
