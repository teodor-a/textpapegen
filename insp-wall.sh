#!/bin/bash
# Make an array called alltext:
declare -a alltext
# Read the text from quotes.txt, making each line an array entry:
readarray alltext < quotes.txt

# Get the length of the array alltext, i.e. how many entries are in it:
alltext_length=${#alltext[@]}
eval quote_indices=({0..$alltext_length..3})
eval author_indices=({1..$alltext_length..3})

declare -a quotes
for i in ${quote_indices[@]}; do
	q=${alltext[$i]}
	#echo $q
	quotes+=("$q")
done

declare -a authors
for j in ${author_indices[@]}; do
	a=${alltext[$j]}
	#echo $a
	authors+=("$a")
done

nquotes=${#quotes[@]}
((nquotes=$nquotes-1))
eval list_to_iterate=({0..$nquotes})

for k in ${list_to_iterate[@]}; do
	#echo ${quotes[$k]}
	#echo ${authors[$k]}
	convert -size 1920x1080  -background black -font Arial -fill white \
		-pointsize 72 -gravity Center caption:"${quotes[$k]}" \
		-pointsize 30 -gravity south -draw "text 600,50 '${authors[$k]}'" \
		$k.png
done