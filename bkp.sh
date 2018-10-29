#!/bin/bash

if [ "$1" == "" ] 
    then
    echo "Usage $0 filename"
    echo "Will copy filename in filename.BAKddmmyy"
    echo ""
    echo "For .C, .cxx, .cpp files will also add"
    echo "a comment on top (c++ style)"
    exit;
fi

outname=`echo $1 | sed 's/\(.*\)\.\(.*\)/\1.BAK.\2/'`
extension=`echo $1 | sed 's/\(.*\)\.\(.*\)/\2/'`
outname=${outname/BAK/BAK`date +%Y%m%d`}


# if files exist add an extra index
i=1;
tmpname=$outname
while [ -e $outname ] 
  do
  i=$((i+1))
  outname=${tmpname/.$extension/_$i.$extension}
done

if [[ "$extension" = "C" || "$extension" = "cpp" || "$extension" = "cxx" ]]
    then
    echo "Insert comment for this backup"
    read COMMENT     
    echo "// BKP(`date +%Y%m%d`) $COMMENT" > $outname 
    echo "" >> $outname 
fi

if [[ "$extension" = "sh" ]]
    then
    echo "Insert comment for this backup"
    read COMMENT     
    echo "# BKP(`date +%Y%m%d`) $COMMENT" > $outname 
    echo "" >> $outname 
fi

if [[ "$extension" = "tex" ]]
    then
    echo "Insert comment for this backup"
    read COMMENT     
    echo "% BKP(`date +%Y%m%d`) $COMMENT" > $outname 
    echo "" >> $outname 
fi

if [[ "$outname" = "$1" ]] 
    then
    outname=${outname}.BAK`date +%d%m%y`
fi




#echo "Extension: $extension"    
echo "$1 --> $outname"
   
cat $1 >> $outname


#cp $1 $outname
