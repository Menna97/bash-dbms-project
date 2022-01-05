#! /bin/bash
typeset -i c
echo enter the table name to delete from
read tname
db=$1
if [ -f databases/$db/$tname ]
   then
	  echo enter the value of primary key in row $i
	  read todelete
	  ex=`awk -F: 'BEGIN{ ex = 0 } { if ( $1 == "'$todelete'" ) ex = 1} END{ print ex }' databases/$db/$tname`
	  if [ $ex -eq 1 ]
	  then
		  sed -i '/'$todelete'/d' databases/$1/$tname
		  tput setaf 3
		  echo the row with $todelete is deleted successfully
		  tupt sgr0
	  else
		  echo this value not exited in $tname
	  fi
else
	   echo "Table $tbname does not exist in database $t"
   fi
function show_menu()
  {
          echo -e "1) Create Table\t 4) Insert Into Table \t 7) Update Table"
          echo -e "2) List Tables \t 5) Select From Table\t 8) Back to mainmenu"
          echo -e "3) Drop Table  \t 6) Delete From Table\t" 

  }
                show_menu

