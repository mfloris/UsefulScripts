#!/bin/bash


# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.
FILE_TO_SHOW=1
COMMAND=echo

# Initialize our own variables:
output_file=""
verbose=0

show_help (){

    echo "tlast, tails last file"
    echo " This script operates on the last file create in the directory"
    echo " Withon arguments, tails the last file."
    echo ""
    echo " Options:"
    echo "    -h           This help"
    echo "    -n FILE_NUM  Which file to operate on (e.g. 2 means second to last, default: $FILE_TO_SHOW)"
    echo "    -c command   Which command to use (default: $COMMAND)"
    echo "    -l lists the last 5 files"
    
    
}

while getopts "h?n:c:l" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    n)  FILE_TO_SHOW=$OPTARG
        ;;
    c)  COMMAND=$OPTARG
        ;;
    l) i=1
       for file in `ls -t | head -5`
       do
	   echo "$i) $file"
	   i=$((i+1))
       done
       exit
       ;;
		
    esac
done




file=`ls -t | head -$FILE_TO_SHOW | tail -1`
echo "File: $file"
$COMMAND $file
