#!/bin/bash
db=$1
typeset -i i
i=1
valid='0-9'
echo "Enter table name to insert data:"
read tbname
if [ -f databases/$db/$tbname ]
then
	# number of columns
	n=`awk -F: 'END{print NF}' databases/$db/$tbname.meta`
	while [ $i -le $n ]
	do
		cname=`awk -F: '{if(NR==1)print $'$i'}' databases/$db/$tbname.meta`
		ctype=`awk -F: '{if(NR==2)print $'$i'}' databases/$db/$tbname.meta`
		while true
		do
			echo "Enter value for column $cname:"
			read value
			if [ $i -eq 1 ]
			then
				repeated=`awk -F: 'BEGIN{repeated=0} {if($1=="'$value'")repeated=1} END{print repeated}' databases/$db/$tbname`
				if [ $repeated -eq 1 ]
				then
					echo "ERROR: primary key constraint violated"
					echo "Primary key must be unique"
					continue
				fi
			fi
			if [ $ctype = int ]
			then
				if [[ $value =~ [^$valid] ]]
				then
					echo "ERROR: Value entered is not int"
				else
					break
				fi
			elif [ $ctype = string ]
			then
				if [[ $value =~ [:] ]]
				then
					echo "ERROR: forbidden character ':'"
				else
					break
				fi
			fi
		done
		if [ $i -eq 1 ]
		then
			record=$value
		else
			record=$record:$value
		fi
		i=$i+1
	done
	echo $record >> databases/$db/$tbname
	echo "New record has been added to $tbname successfully"
else
	echo "Table $tbname does not exist in database $db"
fi
function show_menu()
  {
          echo -e "1) Create Table\t 4) Insert Into Table \t 7) Update Table"
          echo -e "2) List Tables \t 5) Select From Table\t 8) Back to mainmenu"
          echo -e "3) Drop Table  \t 6) Delete From Table\t 9) Exit"

  }
                show_menu

