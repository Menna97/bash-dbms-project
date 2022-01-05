#!/bin/bash
db=$1
valid='a-zA-Z0-9_-'
echo " "
echo "Enter new table name: "
read tbname
if [ -z $tbname ]
then
	echo "ERROR: empty string"
elif [ -f $1/$tbname ]
then
	echo "ERROR: table $tbname already exists"
elif [[ ! $tbname =~ ^[[:alpha:]_]+ ]]
then
        echo "ERROR: invalid table name $dbname"
        echo "Table name must begin with alphabetic characters"
	echo "or underscore only"
elif [[ $tbname =~ [^$valid] ]]
then
	echo "ERROR: invalid table name $dbname"
	echo "Table name must only contain alphanumeric characters, - or _"
else
	touch databases/$1/$tbname
	while true
	do
	echo "Enter number of columns: "
	read n
	if [[ $n =~ [^0-9] ]]
	then
		echo "ERROR: number expected"
	else
		break
	fi
        done
	typeset -i i
	typeset -i repeated
	repeated=0
	i=0
	echo "First column will be primary key"
	while [ $i -lt $n ]
	do
		while true
		do
		echo "Enter column name: "
		read cname
		for col in "${columns[@]}"
		do
			if [ $col = $cname ]
			then
				repeated=1
				break
			fi
		done
		if [[ ! $cname =~ ^[[:alpha:]_]+ ]]
		then
			echo "ERROR: invalid column name"
		elif [[ $cname =~ [^$valid] ]]
		then
			echo "ERROR: invalid column name"
		elif [ $repeated -eq 1 ]
		then
			echo "ERROR: column name already exists"
			repeated=0
		else
			break
		fi
	        done
		while true
		do
		echo "Enter column datatype: "
		echo "1)string"
		echo "2)int"
		read choice
		case $choice in
			1)
				datatype="string"
				break
				;;
			2)
				datatype="int"
				break
				;;
			*)
				echo $choice is not one of the choices
				;;
		esac
	        done
	columns[$i]=$cname
	if [ $i -eq 0 ]
	then
		nameline=$cname
		typeline=$datatype
	else
	       	nameline=$nameline:$cname
		typeline=$typeline:$datatype
	fi
	i=$i+1
	done
	touch databases/$1/$tbname.meta
	echo $nameline >> databases/$1/$tbname.meta
	echo $typeline >> databases/$1/$tbname.meta
	echo "New table $tbname was created successfully"
fi
function show_menu()
  {
          echo -e "1) Create Table\t 4) Insert Into Table \t 7) Update Table"
          echo -e "2) List Tables \t 5) Select From Table\t 8) Back to mainmenu"
          echo -e "3) Drop Table  \t 6) Delete From Table\t "

  }
                show_menu



