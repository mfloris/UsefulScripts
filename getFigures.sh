LIST=`grep -h includegraphics *.tex | sed 's/\\\\includegraphics.*{\\(.*\\)}/\1/g' | grep -v %.*`

LISTPDF=""
#PREFIX="./img"
PREFIX=""
for i in $LIST
do
    LISTPDF="$LISTPDF $PREFIX$i.pdf"
done

for i in $LISTPDF
do
    echo $i
done

#tar cvfz img.tgz $LISTPDF

