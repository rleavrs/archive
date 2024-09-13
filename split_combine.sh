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

uncompress()
{
	echo 'begin uncompress files'
	for file in `ls | grep -v $0`;
	do
		case "${file}" in
		    *.tar) 
		        tar xvf "${file}"
		        ;;
		    *.tar.gz) 
		        tar zxvf "${file}"
		        ;;
		    *.tar.xz)
		        tar Jxvf "${file}"
		        ;;
		    *.tar.bz2)
		        tar jxvf "${file}"
		        ;;
		    *.zip)
		        unzip "${file}"
		        ;;
		    *)
		        echo "not support uncompress: ${file}"
		        exit 1
		        ;;
		esac
	done
}

if [ $1 == 'split' ]; then
	split
elif [ $1 == 'combine' ]; then
	combine
elif [ $1 == 'uncompress' ]; then
	combine
	uncompress
fi
