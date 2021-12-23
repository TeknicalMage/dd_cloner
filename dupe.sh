#!bin/bash

clear
echo "Drive Duplication Script"
sleep 0.5

sleep 1.0

echo " "
echo -e "\e[1;41m press enter to begin \e[1;m"

read null

clear

#Drive data dump. Sorting for things that measure in gigs ala big drives
sudo fdisk -l | grep GiB > text.txt


#Count for how many disk or groups are around
drives=$(wc -l text.txt)

num=$(echo $drives | tr -d 'text.txt')


num="$(($num+0))"
echo $num disks / partiton groups dectected


#Loop Displays what is connected where and assigns a number to it for selection
for ((i=1;i<=$num;i++));
do

        sleep .5
        echo - ${i} -
        #Splits the differnt Drives into lines
        wah=$(sed -n "${i}p" < text.txt)

        echo ${wah}
        echo "${wah%:*}"
done

echo " "
echo " "

echo "Please select the orgin Drive"
sleep .3
echo -e  "\e[1;41m Please select or type 1-${num} \e[1;m"
#The bracket 1:41m                                  [1;m makes this line red
#Completely worth the 5 minutes it took to google that



#Input from the above query
read nput

#OF Is the FLAG for orignal drive that is being copied
of_raw=$(sed -n "${nput}p" < text.txt)
of_less_raw="${of_raw%:*}"
of_select=$(echo $of_less_raw | sed 's/^Disk //')


#Finally some good output of the drive path
echo -e "\e[1;42m $of_select \e[1;m"


echo "Please Select the destination Drive"
echo -e "\e[1;41m Please Select or type 1-${num} \e[1;m"

#Input from the Query Directly Above
read nputend

#IF if the drive being copied to. The clone of the "drive cloning
if_raw=$(sed -n "${nputend}p" < text.txt)
if_less_raw="${if_raw%:*}"
if_select=$(echo $if_less_raw | sed 's/^Disk //')

#Completed Output for the "clone"
echo -e "\e[1;42m$if_select\e[1;m"
echo "Press Enter to Start Dupe"

read null

#TLDR   OG Drive      Future Clone  Something about sizes and how data is read (I think)
sudo dd if=$if_select of=$of_select bs=64k status=progress
#                                          Not really needed but in case I write this to a file and make my own progress bar
