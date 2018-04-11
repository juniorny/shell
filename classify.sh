#!/bin/bash

if [ $1 = '']
then
	echo "usage: ./classify.sh <number>"
else

	if [ -e result ]
	then
		if [ -e result/train ] && [ -e result/test ]
		then
			echo "start to classify..."
		else
			if [ ! -e result/train ]
			then
				echo "create train dir"
				mkdir result/train
			fi
			if [ ! -e result/test ]
			then
				echo "create test dir"
				mkdir result/test		
			fi	
		fi
	else
		echo "create result dir"
		echo "create result/train dir"	
		echo "create result/test dir"
		mkdir result
		mkdir result/test
		mkdir result/train
	fi

	n=1
	until [ $n -gt $1 ]
	do
		class="`awk -v awk_var="$n" 'NR==awk_var {print $2}' train_test_split.txt`"
	#	echo "class = $class"
		dir="`awk -F'[ /]' -v awk_var="$n" 'NR==awk_var {print $2}' images.txt`"
	#	echo "dir = $dir"
		jpg="`awk -F'[ /]' -v awk_var="$n" 'NR==awk_var {print $3}' images.txt`"
	#	echo "jpg = $jpg"
		if [ $class -eq 0 ]
		then
			if [ ! -e result/test/$dir ]
			then
				echo "create $dir"
				mkdir result/test/$dir
			fi			
			cp -n images/$dir/$jpg result/test/$dir
		else
			if [ ! -e result/train/$dir ]
			then
				echo "create $dir"
				mkdir result/train/$dir
			fi
			cp -n images/$dir/$jpg result/train/$dir			
		fi
		n=$(($n+1))
	done
	echo "classify complete!"
fi
