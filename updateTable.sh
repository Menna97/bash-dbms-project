#!/bin/bash
db=$1
valid='0-9'
echo "Enter table name to update data:"
read tbname
if [ -f databases/$db/$tbname ]
then
	columns=`awk 'BEGIN{FS=":";OFS=" "} {if(NR==1){$1=$1;print $0}}' databases/$db/$tbname.meta`
	while true
	do
		echo "Choose column to update its value:"
		echo $columns
		read col
		checkcol=`awk -F: 'BEGIN{checkcol=0} {if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col'")checkcol=1}}} 
		END{print checkcol}' databases/$db/$tbname.meta`
		if [ $checkcol -eq 0 ]
		then
			echo "ERROR: $col is not a column in $tbname"
		elif [ $checkcol -eq 1 ]
		then
			break
		fi
	done
	iskey=`awk -F: 'BEGIN{iskey=0} {if(NR==1){if($1=="'$col'")iskey=1}} END{print iskey}' databases/$db/$tbname.meta`
        colnum=`awk -F: 'BEGIN{num=0} {if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col'"){num=i;break;}}}}
        END{print num}' databases/$db/$tbname.meta`
	coltype=`awk -F: '{if(NR==2)print $'$colnum'}' databases/$db/$tbname.meta`
	while true
	do
		echo "Enter new value for $col:"
		read newval
		if [ $iskey -eq 1 ]
                then
			repeated=`awk -F: 'BEGIN{repeated=0} {if($1=="'$newval'")repeated=1} END{print repeated}' databases/$db/$tbname`
                        if [ $repeated -eq 1 ]
                        then
				echo "ERROR: primary key constraint violated"
                                echo "Primary key must be unique"
                                continue
                        fi
	       	fi
                if [ $coltype = int ]
                then
			if [[ $newval =~ [^$valid] ]]
                        then
				echo "ERROR: Value entered is not int"
			else
				break
                        fi
		elif [ $coltype = string ]
		then
			if [[ $newval =~ [:] ]]
			then
				echo "ERROR: forbidden character ':'"
			else
				break
			fi
		fi

	done
	while true
	do
		echo "Enter primary key value of the record you want to update:"
		read pk
		checkpk=`awk -F: 'BEGIN{checkpk=0} {if($1=="'$pk'")checkpk=1} END{print checkpk}' databases/$db/$tbname`
		if [ $checkpk -eq 0 ]
		then
			echo "ERROR: primary key does not exist"
		elif [ $checkpk -eq 1 ]
		then
			rownum=`awk -F: '{if($1=="'$pk'")row=NR} END{print row}' databases/$db/$tbname`
			break
		fi
	done
	awk 'BEGIN{FS=":";OFS=":"} {if(NR=="'$rownum'")$'$colnum'="'$newval'";print}' databases/$db/$tbname > temp && cp temp databases/$db/$tbname
	rm temp
	tput setaf 3
	echo table $tname is update succesfully
	tput sgr0
else
	echo "Table $tbname does not exist in database $db"
fi
function show_menu()
  {
          echo -e "1) Create Table\t 4) Insert Into Table \t 7) Update Table"
          echo -e "2) List Tables \t 5) Select From Table\t 8) Back to mainmenu"
          echo -e "3) Drop Table  \t 6) Delete From Table\t "

  }
                show_menu

