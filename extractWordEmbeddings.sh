#/bin/bash

# extracts attachments from word documents

filename=$1
folder=${filename}_emb

mkdir "$folder"
mkdir "$folder/tmp"
pwd
cd "$folder/tmp"
unzip "../../$filename" > /dev/null 
cp word/embeddings/* ..
cd ..
rm -rf tmp
for file in `grep -l "Acrobat Document" *`
do
    mv $file ${file/bin/pdf}
done
