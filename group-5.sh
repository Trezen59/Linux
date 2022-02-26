#!/bin/bash

# Group 5 Project

# script to add users from different streams : 3 streams science, commerce and arts
# science students with roll.no in sci.txt
# commerce students with roll.no in com.txt
# arts students with roll.no in arts.txt
# all .txt files in same directory as .sh files are in 

echo " "

add_users(){                                  # function to add users

		for i in $(cat $2)                    
		do
		
		username="${1}-${i}"                  # science-180140111059
		
		sudo useradd -m $username             # science-180140111059 as username

		[ $? -eq 0 ] && echo "user $username added successfully" || "failed to add user $username "

		echo $username:$i | sudo chpasswd     # username:password piped to chpasswd

        	[ $? -eq 0 ] && echo "passwd for $username changed" || "failed to change passwd for $username"

		done
		echo " "
	
}

del_users(){                                  # delete users

		for i in $(cat $2)              
		do
		
		username="${1}-${i}"
		
		sudo userdel $username
		[ $? -eq 0 ] && echo "user $username deleted" || "could not delete $username "
		
		done
		echo " "
}

backup(){                                    # take backup of users

		for i in $(cat $2)                   
		do
		username="${1}-${i}"                
		
		dest=/home/trezen/BOSS
		src=/home/$username

		[ ! -d $dest ] && mkdir -p $dest
		[ ! -d $src ] && { echo " $src directory not found, exiting. " exit1; }

		echo "backup started"

		sudo tar -zcvpf $dest/$username.tar.gz $src 2>/dev/null
		[ $? -eq 0 ] && echo "backup done" || echo "backup failed"

		echo " "
		done

}


echo "Welcome to our program to add users..!"
echo " "

while true                            # keep taking inputs after every operations done
do
	
	echo "1. Add Users"
	echo "2. Backup and Delete Users"
	echo "3. Exit"
	echo " "
	echo "Please select what you want to do : "

	read choice                   # input the choice

	 
	if [ $choice -lt 4 ]           # check the choice if it is present in our menu 
	
	then                           # if choice present then do the resp. operation

		case $choice in

			1)  echo "Adding Users"
				echo " "
				
				add_users science sci.txt
				  
				add_users commerce com.txt
				
				add_users arts arts.txt
				
				echo "All users added successfully...!"
				echo " "
				echo "----------------------------------------------------------------------"
				echo " "
				;;
				
			2)	echo "Starting Backup..!"
				echo " "
			
				backup science sci.txt
				del_users science sci.txt                     

				backup commerce com.txt
				del_users commerce com.txt

				backup arts arts.txt
				del_users arts arts.txt
				
				echo "Backedup and successfully deleted users...!"
				echo " "
				echo "---------------------------------------------------------------------"
				echo " "
				;;
				
			3)  echo "Thank you...!"
				exit 1

				;;
		esac       # case end

	else
		echo "enter valid choice"        # if invalid choice entered exit immediately
		echo " "
		exit 1
			
	fi     # if end

	
	
done  # while end






