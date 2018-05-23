#!/bin/bash

while true
do
	total1=`awk 'NR==1 {for(i=2;i<=NF;i++) sum+=$i} END{print (sum+0)}' /proc/stat`
	idle1=`awk 'NR==1 {print ($5+0)}' /proc/stat`
	sleep 1s
	total2=`awk 'NR==1 {for(i=2;i<=NF;i++) sum+=$i} END{print (sum+0)}' /proc/stat`
	idle2=`awk 'NR==1 {print ($5+0)}' /proc/stat`
	total=$[$total2-$total1]
	idle=$[$idle2-$idle1]
	cpu_usage=`echo "$total $idle" | awk '{printf("cpu_usage = %.2f%%\n", ($1-$2)/$1*100)}'`
	echo $cpu_usage
done
