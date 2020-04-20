#!/bin/bash
echo "RUN THIS SCRIPT BEFORE AB'S, TO PREVENT AB FROM ACCIDENTALLY OVERWRITING FILES IF THE MAX NUMBER DM KNEW ABOUT WAS SMALLER THAN THE BIGGEST REAL NUMBER"
for f in $(find ./ -type d )
do
    LIST=`exec ls /c/Users/jadedResearcher/IdeaProjects/DollLibCorrect/example/images/$f/*.png | sort -rV`
    big=-113
    bigNum=-113
    for doop in $LIST
    do
        big="${doop##*/}"
        bigNum="${big%.*}"

        re='^[0-9]+$'
        if ! [[ $bigNum =~ $re ]] ; then
           echo "error: $bigNum is not a number, trying next."
        else
            echo $bigNum is definitely a number. it has to be.
            break;
        fi
    done
    echo last biggest number is $bigNum

    for file in  `ls $f/*.png | sort -V`
    do
        bigNum=$((bigNum + 1))
        newFile=${f}/${bigNum}jr.png
        echo $file but it seems it should be $newFile
        `exec mv $file $newFile`
    done


done

