#! /bin/bash
db=$1
function select_all()
{
    echo enter table name to select from
    read tname
    db=$1
    if [ -f databases/$db/$tname ]
     then
	     tput setaf 3
	awk -F: '{print $0}' databases/$db/$tname
	    tput sgr0
else
	echo $tname not exit in $db
      fi
}
function select_column()
{
  echo enter table name to select from
  read tname
  db=$1
  if [ -f databases/$db/$tname ]
   then
          echo enter column name to select from
          read cname
          j=`awk -F: 'BEGIN{ i=0;j } {
          while( i<=NF )
                  {if($i=="'$cname'") { j=i;print j}i++;
		  }}' databases/$db/$tname.meta`
          if [ $j -ne 0 ]
               then
		       tput setaf 3
                awk -F: '{print $'$j'}' databases/$db/$tname
		      tput sgr0
           else
                  echo no column with this name in table $tname
                  select_table
            fi
     else
           echo "Table $tbname does not exist in database $tname"
    fi

}
function select_table()
{
typeset -i z
z=0
echo enter table name to select from
read tname
db=$1
if [ -f databases/$db/$tname ]
   then
          echo enter column name to select from
	  read cname
	 j=`awk -F: 'BEGIN{ i=0;j } {
	  while( i<=NF )
		  {if($i=="'$cname'") { j=i;print j}i++;

	    }}' databases/$db/$tname.meta`
	    if [ $j -ne 0 ]
	       then
                  echo enter term to select
		  read fname
		  z=`awk -F: '{ if ($'$j'=="'$fname'") z=1} END{ print z }' databases/$db/$tname`
		  if [ $z -eq 1 ]
		     then
		        tput setaf 3
		        awk -F: '{if ($'$j'=="'$fname'") print $0 }' databases/$db/$tname
		        tput sgr0
		else
			echo no data with $fname in table $tname
		fi
	       else
		  echo no column with this name in table $tname
	       	  select_table
	    fi
    else
           echo "Table $tbname does not exist in database $t"
   fi

}
PS3="Make an option-->"
select choice in 'Select All' 'Select a Column' 'Select under condition'
do
        case $REPLY in
                1)
                        select_all $1
			exit 0
                        ;;
                2)
                       select_column $1
		       exit 0
                        ;;
                3)
                       select_table $1
		       exit 0
                        ;;
                *)
                        echo $REPLY is not an option
                        ;;
         esac
done
function show_menu()
  {
          echo -e "1) Create Table\t 4) Insert Into Table \t 7) Update Table"
          echo -e "2) List Tables \t 5) Select From Table\t 8) Back to mainmenu"
          echo -e "3) Drop Table  \t 6) Delete From Table\t"  

  }
                show_menu

