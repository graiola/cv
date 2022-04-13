#!/bin/bash

# STARTUP
#Check if images folder exists
#Check if README.md exists
CV_NAME="CV_Gennaro-Raiola"
MD_NAME="README.md"
FOLDER_NAME="images"
CURR_DATE=`date`

sudo apt-get update
sudo apt-get install texlive-xetex texlive-lang-other texlive-latex-recommended texlive-fonts-extra

if [ ! -d ./$FOLDER_NAME ]; then
    mkdir $FOLDER_NAME
fi
if [  -f ./$MD_NAME ]; then
    rm $MD_NAME
fi

touch $MD_NAME

xelatex $CV_NAME.tex

pdftoppm $CV_NAME.pdf ./$FOLDER_NAME/$CV_NAME -png

NUM_PAGES=`ls -l $FOLDER_NAME | grep .png | wc -l`

for PAGE in $(seq $NUM_PAGES)
do
   echo "![$PAGE](images/$CV_NAME-$PAGE.png)" >> $MD_NAME
done

# Finally commit and push the generated files
git add $CV_NAME.pdf $CV_NAME.tex $MD_NAME $FOLDER_NAME
git commit -m "Generated files updated on $CURR_DATE"
git push
