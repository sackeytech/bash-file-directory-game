#!/bin/bash
directory(){
dir=$1
if [ -z "$(echo "$dir" | tr -d ' ')" ]
then
	echo "Invalid input: You have entered an empty name or just spaces."
	echo "You have lost this round"
	echo "-----------------------------"
	return 1
fi

if [ -d  "$HOME/$dir" ]
then
	echo "The directory $dir exist."
	echo "The path to the directory is:  $(realpath "$HOME/$dir") "
	echo "You have won the round"
	echo ""
	echo "---------------------------"	
	return 0
else
	echo "As of $(date), The directory doesnt exist."
	echo "You have lost this round"
	echo " "
	echo "---------------------------"
	return 1
fi	

}

file(){
File=$1
if [ -f  ~/"$File" ]
then
	echo "The file $File exists."
	echo "The path to the file is:  $(realpath "$File")"
	echo "You have won this round"
	echo ""
	echo "---------------------------------"
	return 0
else
	echo "As of $(date), The file doesnt exist."
	echo "You have lost this round"
	echo ""
	echo "---------------------------------"
	return 1

fi
}

directoryandfile(){
diroundswon=$1
diroundslost=$2
fileroundswon=$3
fileroundlost=$4
totalround=$5

dirtotal=$((diroundslost + diroundswon))
filtotal=$((fileroundlost + fileroundwon))



if [ "$diroundswon" -gt "$diroundslost" ]
then
	echo "You won the Directory game"
	echo "Congralution !!!!"
	echo "Total Directory game played $dirtotal"
	echo "Total Directory game won is $diroundswon"
	echo "Total Directory game lost is $diroundslost"

elif [ "$diroundswon" -lt "$diroundslost" ]
then
	echo "You lost the Directory Game"
	echo "Total Directory game played $dirtotal"
	echo "Total Directory game lost is $diroundslost"
	echo "Total Directory game won is $diroundswon"
else 
	echo "Tie Game !!!"
fi

if [ "$fileroundwon" -gt "$fileroundlost" ]
then
	echo "You won the file game "
	echo "Congralution !!!"
	echo "Total File game played $filtotal"
	echo "Total File game won is $fileroundwon"
	echo "Total File game lost is $fileroundlost"

elif [ "$fileroundwon" -lt "$fileroundlost" ]
then
	echo "You lost the file game"
	echo "Total File game played $filtotal"
	echo "Total File game won $fileroundswon"
	echo "Total File game lost $fileroundslost"
else
	echo "Tie Game !!!"
fi

fileanddirectorywon=$((fileroundwon + diroundswon))
fileanddirectorylost=$((fileroundlost + diroundslost))
echo " "
echo "-----------------------------------------------"
echo "FINAL OUTPUT OF THE FILE AND DIRECTORY GAME"
echo "------------------------------------------------"
if [ "$fileanddirectorywon" -gt "$fileanddirectorylost" ]
then
	echo "YOU WON THE GAME "
	echo "Congralution !!!!!!!"
	echo ""
	echo "RECORDS"
	echo "Total Game played is $totalround"
	echo "Total rounds won is $fileanddirectorywon"
	echo "Total rounds lost is $fileanddirectorylost"
elif [ "$fileanddirectorywon" -lt "$fileanddirectorylost" ]
then
	echo "YOU LOST THE GAME !!!!!!"
	echo "RECORD"
	echo "Total Game played is $totalround"
	echo "Total rounds won is $fileanddirectorywon"
	echo "Total rounds lost is $fileanddirectorylost"

else
	echo "Tie Game !!!"
fi
}


echo "WELCOME TO THE DIRECTORY AND FILE GAME."
echo ""


read -p "If you will like to play the game press(y) for YES and press(n) for NO: " response
echo ""

if [ $response = "y" ]
then
	echo "We can start the game now " 
	echo "You can choose to play only the File or Directory Game or Both"
	read -p "To choose file game only press(1),press(2) for directory ,press(3) for both: " playresponse
	 rounds=1
	if [ $playresponse -eq 1 ]
	then
		echo ""
		read -p "Enter the number of rounds you want to play: " filerounds
		fileroundwon=0
		fileroundlost=0
		while [ $rounds -le $filerounds ]
		do
			echo " "
			read -p "Enter the Name of the file:" filename
			
			file $filename
			status=$?
			if [ $status -eq 0 ]
			then
				fileroundwon=$(($fileroundwon + 1))
			else
				fileroundlost=$(($fileroundlost + 1))
			fi
			rounds=$(($rounds + 1))
		done
		if [ $fileroundwon -gt $fileroundlost ]
		then
			echo "You have won the game."
			echo "Rounds won is $fileroundwon"
			echo "Rounds lost is $fileroundlost"
			echo "Congratulation !!!!!"
		elif [ $fileroundwon -lt $fileroundlost ]
		then
			echo "You Lost the game."
			echo "Rounds lost is $fileroundlost"
			echo "Rounds won is $fileroundwon"
			echo "Try again next time !!!"
		else
			echo "It's a tie game !!!"

		fi
	elif [ "$playresponse" -eq 2 ]
	then
		echo " "
		read -p "Enter the number of rounds you want to play: " dirrounds
		dirroundswon=0
		dirroundslost=0
		roundperplay=1
		while [ "$roundperplay" -le "$dirrounds" ]
		do
			read -p " Enter the directory you want to check: " dircheck
			directory "$dircheck"
			dirstatus=$?
			if [ "$dirstatus" -eq 0 ]
			then
				dirroundswon=$((dirroundswon + 1))
			else
				dirroundslost=$((dirroundslost + 1)) 
			fi
			
			roundperplay=$((roundperplay + 1))
	
		done
			totalroundplayed=$((roundperplay - 1))
			if [ "$dirroundswon" -gt "$dirroundslost" ]
			then
				echo "You have won the game."
				echo "Total rounds played is $totalroundplayed"
				echo "Rounds won is $dirroundswon"
				echo "Rounds lost is $dirroundslost"
				echo "Congralution !!!!" 
			elif [ "$dirroundswon" -lt "$dirroundslost" ]
			then
				echo "You have lost the game."
				echo "Total rounds played is $totalroundplayed"
				echo "Rounds lost is $dirroundslost"
				echo "Rounds won is $dirroundswon"
				echo "Try again next time !!!"
			else
				echo "It is a tie game !!!"
			fi
	elif [ "$playresponse" -eq 3 ]
	then
		echo " "
		read -p "Enter the number of rounds you want to play for files: " filerounds
		read -p "Enter the number of round you want to play for directory: " dirounds
		
		totalround=$((filerounds + dirounds))
		echo "------------------------------"
		echo "Starting with file rounds"
		echo "------------------------------"

		fileroundwon=0
		fileroundlost=0
		rounds=0
		while [ "$rounds" -lt "$filerounds" ]
		do	echo " "
			read -p "Enter the file you want to search for: " filename
			file "$filename"
			filestatus=$?
			
			if [ "$filestatus" -eq 0 ]
			then
				fileroundwon=$((fileroundwon + 1))
			elif [ "$filestatus" -eq 1 ]
			then
				fileroundlost=$((fileroundlost + 1))
                        fi
		        rounds=$((rounds + 1))

		done
		fileroundsaved="$rounds"
		rounds=0
		echo "-----------------------------"
		echo "DIRECTORY SECTION"
		echo "----------------------------"

		diroundwon=0
		diroundlost=0
		while [ "$rounds" -lt "$dirounds" ]
		do
			echo " "
			read -p "Enter the directory you want to search for: " dirname
			directory "$dirname"
			dirstatus=$?
			
			if [ "$dirstatus" -eq 0 ]
			then
				diroundwon=$((diroundwon + 1))
			elif [ "$dirstatus" -eq 1 ]
			then
				diroundlost=$((diroundlost + 1))
			fi
			rounds=$((rounds + 1))
			
		done
		
		directoryandfile "$diroundwon" "$diroundlost" "$fileroundwon" "$fileroundlost" "$totalround"  

	fi			
else
	echo "EXIT GAME !!!"
fi
