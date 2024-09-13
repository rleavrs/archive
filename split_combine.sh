#!/bin/bash

shell_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

split()
{
	echo 'begin split files'
	for file in `ls ${shell_path} | grep -v $0`;
	do
		echo "split ${file}"
		`which split` -b 1M -d -a 6 ${file} ${file}.
		rm -rf ${file}
	done
}

combine()
{
	echo 'begin combine files'
	for file in `ls | grep -v $0 | sed 's/\.[^\.]*$//' | uniq`;
	do
		echo "combine ${file}"
		`which cat` ${file}.* > ${file}
		rm -rf ${file}.*
	done
}

if [ $1 == 'split' ]; then
	split
elif [ $1 == 'combine' ]; then
	combine
fi
