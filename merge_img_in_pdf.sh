format="jpg"
if [ "$1" = "" ]
then
    echo "Usage: "
    echo "merge_img_in_pdf.sh dirname [format]"
    echo "merges all img in dir in file called dirname.pdf"
    echo "optionally you can specify the format of images (default $format)"
    exit
fi
if [ "$2" != "" ]
   then
   format="$2"
fi

directory=$1
filename=`basename $directory`.pdf
cd $directory
for i in  *.$format
do
    echo "Converting $i -> ${i/$format/pdf}"
    convert -strip -quality 75  "$i" "${i/$format/pdf}"
done

gs -dBATCH -dNOPAUSE \
    -dAutoFilterColorImages=false \
    -dAutoFilterGrayImages=false \
    -dColorImageFilter=/FlateEncode \
    -dGrayImageFilter=/FlateEncode \
    -dJPEGQ=100 -q -sDEVICE=pdfwrite -sOutputFile=$filename `ls *.pdf`

mv ${filename} ..

echo "Created $filename"

cd ..
