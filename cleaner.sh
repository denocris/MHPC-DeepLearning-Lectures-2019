#!/bin/sh

text=$1

echo "Removing patterns like '-RRB-'"
sed 's/-[A-Z]\+\-//g' $1 > cl_0


#echo "Removing punctuation exept !',?"
#sed -e "s/[^a-zA-Z0-9àèéìò\!',?\* ]//g" $1 > cl_0

echo "Removing punctuation exept '"
sed -e "s/[^a-zA-Z0-9àèéìò\'\* ]//g" cl_0 > cl_1

echo "Remove numbers at the beginning and double quotes '' "
sed -e 's/^[0-9]*//g' cl_1 | sed -e "s/''//g" > cl_2

rm cl_1

echo "Remove diacritics"
cat cl_2 | iconv -f utf8 -t ascii//TRANSLIT//IGNORE > cl_3

rm cl_2

echo "Remove diacritics"
cat cl_3 | tr '[:upper:]' '[:lower:]' > cl_4

rm cl_3

echo "Remove whitespace at the beginning and at the end of the line and strip multiple whitespaces..."
sed -r 's/[[:blank:]]*$//g' cl_4 | sed -r 's/^[[:blank:]]*//g' | sed 's/  */ /g ' > $1_clean.tsv

rm cl_4
