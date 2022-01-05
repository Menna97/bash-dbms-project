#!/bin/bash
valid='a-zA-Z0-9_-'
echo " "
echo "Enter new database name:"
read dbname
 if [ ! -d databases ]
 then
	 mkdir databases
 fi 

if [ -z databases/$dbname ]
then
	echo "ERROR: empty string"
elif [ -d databases/$dbname ]
then
	echo "ERROR: database $dbname already exists"
elif [[ !$dbname =~ ^[[:alpha:]]+ ]]
then
	echo "ERROR: invalid database name $dbname"
	echo "Database name must begin with alphabetic characters only"
elif [[ $dbname =~ [^$valid] ]]
then
	echo "ERROR: invalid database name $dbname"
	echo "Database name must only contain alphanumeric characters, - or _"
else
	mkdir databases/$dbname
	echo "New database $dbname was created successfully"
fi
