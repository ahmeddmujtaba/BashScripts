#!/bin/bash
echo "Choose a feature you would like to implement"
echo "Enter 1 to implement the tag feature"
echo "Enter 2 to implement the filesize feature"
echo "Enter 3 to implement the extension feature"
echo "Enter 4 to implement the switch to executable feature"
echo "Enter 5 to implement the backup and restore feature"
echo "Enter 6 to implement the duplicate deletion feature"
echo "Enter 7 to implement the wordcount feature"
read feature
if [ "$feature" == "1" ] ; then
   echo You picked the tag feature
   echo "Input the search Tag"
   read tag
   nans=$(grep -r '^#' ..| grep "$tag"| grep ".py")
   echo These are the lines containg your inputted tag :"$tag"
   echo "$nans"

   if [ -e tag.log ]; then
      > Tag.log
      echo "$nans" >> Tag.log
      echo Tag.log has been updated
   else
      touch Tag.log
      echo "$nans" >> Tag.log
      echo Tag.log has been created and updated
   fi

elif [ "$feature" == "2" ] ; then
   echo You picked the filesize feature
   name=$(ls -lhAR ..|grep -v '^d' | awk '{print $5 "B : " $9}'| grep . |grep -v '^B'|sort -hfr |uniq )
   echo "$name"

elif [ "$feature" == "3" ] ; then
   path=$(pwd)
   echo You picked the extension feature
   echo "Enter the extension for which you like to search for"
   read ext
   ans=$(ls -R .. |grep -c ".$ext")
   echo There are "$ans" files with "$ext" extension
elif [ "$feature" == "4" ] ; then

   echo "C for change or R for restore"
   read userinput
   if [ "$userinput" == "C" ] ; then
      perm=$(find -name "*.sh"|xargs stat -c '%a %N')
#      if [ -e permissions.log ]; then
#            > permissions.log
#            echo "$perm" > permissions.log
#         else
#            touch permissions.log
#           echo "$perm" > permissions.log
#         fi
    echo "$perm" > permissions.log 
     find -name "*.sh" | xargs chmod -x
      find -name "*.sh" -perm -g=w| xargs chmod g+x
      find -name "*.sh" -perm -o=w| xargs chmod o+x
      find -name "*.sh" -perm -u=w| xargs chmod u+x
   elif [ "$userinput" == "R" ] ; then
      perms=( $(cat permissions.log|sed "s/'/ /g") )

      for ((i=0;i<${#perms[@]};i+=2)); do
            chmod ${perms[i]} ${perms[i+1]}
         done
#for ((i=0;i<${#from[@]};i++)); do
 #     cp ${new[i]}
  # done
   else
      echo "That was not a proper input"

   fi
elif [ "$feature" == "5" ] ; then
   bash ./feature5script
elif [ "$feature" == "6" ] ; then
   files=( $(ls -l) )
for element in "${files[@]}"
do
 find -type f|xargs sha256sum | sort -k1 | uniq -w 64 -d| awk '{print $2}'|xargs rm 
 ans=$(find -type f|xargs sha256sum | sort -k1 | uniq -w 64 -d)
 if [ -z "$ans" ]; then
      break
 fi
done
clear
echo ALL DUPLICATE FILES HAVE BEEN DELETED
elif [ "$feature" == "7" ] ; then
   echo "Enter name of file"
   read file

   x=$(grep -oE '[[:alpha:]]+' "$file" | sort | uniq -c | sort -nr)
   echo "$x" > temp.log

   word=( $(cat words) )
      for element in "${word[@]}"
      do
         y=$(cat temp.log| grep -v "${element}")
         echo "$y" > temp.log
      done
   final=$(cat temp.log| head -20)
   echo "$file":
   echo "$final"
   rm temp.log
else
   echo "That was not a proper input"

fi

# ls -lhSaR |grep . | awk '{print $5 " : " $9 "B"}'|
# custom feature idea: user inputs a word and ill display the amount of times they have used that word in their text files, total
# or just output the number of times they have used their most used word
# use md5sum to get hashes of files to see there are no duplicates


