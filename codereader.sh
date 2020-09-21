#!/bin/bash
f=0
err=0
prefix="CODE-128:"
for filepath in input/*
do
    file=$(basename $filepath)
    pdftoppm -png input/"$file" pngfiles/"$file"
    barcode=$(zbarimg -q pngfiles/"$file"-1.png)
    name=${barcode#"$prefix"}

    if [ -z "$name" ]
	then
      		mv "$filepath" errorfiles/"$err".pdf
		err=$((err+1))
		echo "Errore!"
	else
         	echo "$name"
	        mv "$filepath" output/"$name".pdf
    fi


    f=$((f+1))
done


echo "Ho elaborato $f file"
echo "Di cui $err file con errori"
