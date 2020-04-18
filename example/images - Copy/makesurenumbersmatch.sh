#!/bin/bash
for f in $(find ./ -type d )
do
    LIST=`exec ls /c/Users/jadedResearcher/IdeaProjects/DollLibCorrect/example/images/$f/*.png | sort -rV`
    echo sub is $f list is $LIST
    big=-1
    for doop in $LIST
    do
        big="${doop##*/}"
        break;
    done
    bigNum="${big%.*}"
    echo big is $bigNum

    for file in $f/*.png
    do
        bigNum=$((bigNum + 1))
        echo $file but i know it should be ${f}/${bigNum}.png
    done


done

