#!/bin/bash
tput setaf 3
echo " "
echo "*****Welcome to DBMS*****"
echo "-------------------------"
tput sgr0
PS3="Make a choice-->"
select choice in 'Create Database' 'List Databases' 'Connect to Database' 'Drop Database' 'Exit'
do
	case $REPLY in
		1)
			./createDatabase.sh
			;;
		2)
			./ListDatabase
			;;
		3)
		      ./ConnectToDatabase
			;;
		4)
			./DropDatabase
			;;
		5)
			exit 0
			;;
		*)
			echo "$REPLY is not one of the choices"
			;;
	esac
done
