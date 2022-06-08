#!/bin/bash

#create directory calls Database to store all the created database
myPath=/home/amir/Database
if ! [[ -d $myPath ]]
then
	mkdir $myPath
else
	echo  "File Database is already created"
fi

#assign a string to db_name variable
db_name=" "

#make a select to show all options of my DBMS

select menu in create list connect drop "exit"
do
	
	case $menu in

		#Creating a database 
		"create" )
			until [[ $db_name =~ [[:alpha:]] ]]
			do
				#Asking the user about the name of the DB
				read -p "enter the database name(string only): " db_name
			
				#make sure that the variable is only alphabit and not empty
			
				if [[ $db_name =~ [[:alpha:]] ]]
				then
					mkdir $myPath/$db_name
				else
					echo "Invalid input"
				fi
				done
			;;
		"list")
			ls -1 $myPath
			;;
		"connect" )
			#Asking the user about the database he wants to connect
			read -p "Please enter the database name you want to connect: " DB_connect
			#Checking the DB we are connecting to is alreday existing
			if [[ -d $myPath/$DB_connect ]]
			then
				#Path of the table directory
				TablePath=$myPath/$DB_connect
			
			select connect in "Create Table" "List Table" "Drop Table" "Delete from Table" "Insert to table" "Select Table"  "Update to table"
			do
				case $connect in
				"Create Table" )
					
					read -p "Enter the table name: " tablename
					#Check that the tablename is alphabetic only
					if [[ $TablePath/$tablename =~ [[:alpha:]] ]]
					then
						path_new=/home/amir/Database/$DB_connect/$tablename
						#Variable to connect with anything starts with the tablename
						var=("${path_new}"*)
						
						#check that the table name exists
						if  [[ -f $var ]]
						then
							echo "Table already exists"
						else
							read -p "Enter table columns number: " columns
							echo "-------Note-------"
							echo "First column is primary key"
						
							#loop to create the columns and seperates them with ':'
						
							for (( i=1 ; i <= $columns ; i++ ))
							do
							    read -p "Enter the column $i datatype[STR/INT]: " column_datatype
							#Check the column datatybe is STR or str only
							    if [[ $column_datatype == "STR" || $column_datatype == "str" ]]
							    then
							        echo -n "STR" >> $TablePath/$tablename.datatype
							
							        read -p "Enter the column number $i name : " column_name
							
							        echo -n $column_name >> $TablePath/$tablename
							#Check the column datatybe is INT or int only
							    elif [[ $column_datatype == "INT" || $column_datatype == "int" ]]
							    then
							
							        echo -n "INT" >> $TablePath/$tablename.datatype
							
							        read -p "Enter the column number $i name : " column_name
							
							        echo -n $column_name >> $TablePath/$tablename
							#If the user enters anything else 
								else
							
							        echo "INVALID DATATYPE ,TRYAGAIN"
									let i=$i-1
									break
							    fi
							#Check if the iterator equals to the columns , it will exist
							    if [[ $i -ne $columns ]]
							    then
							    echo -n ":"  >>  $TablePath/$tablename
							    echo -n ":"  >> $TablePath/$tablename.datatype
							    fi

							done

						fi
					#prints if the table name is not alphabetic
					else
						echo "Invalid table name"

					fi
					;;
				"List Table" )
					ls -1 $TablePath
					;;
				"Drop Table" )
					read -p "Please enter the DB table you want to remove: " Table_remove
					#check if the table exists or not
					if [[ -f $TablePath/$Table_remove ]]
					then
						#Removing the chosen table
						rm -i $TablePath/$Table_remove*
					else
						echo "Table not found"
					fi
					;;
				
				"Delete from Table" )
						
						read -p "enter the table name you want to delete from: " table_delete
						#check if the table exist
						if [[ -f $TablePath/$table_delete ]]
						then
						    pks=`cut -f1 -d ':' $TablePath/$table_delete`
						
						    read -p "enter the pk of row you want to delete: " pk
							#check if the primary key exists in the primary keys column
							for i in $pks
						    do
							#if exists we delete the entire row of it
						        if [ "$i" == "$pk" ];then
						        sed -i "/$i/d" $TablePath/$table_delete
						        echo the row is deleted 
						        break
								fi
							done
							#re define the number of the primary keys after deletion 
							pks2=`cut -f1 -d ':' $TablePath/$table_delete`
							#comparing the the primary keys number befor and after the deletion to identify if there is deletion happend
							if [ "$pks" == "$pks2" ]
							then
							echo "this pk does not exist"
							fi

						else
						echo "Table not found"
						fi

					;;


####################################################################################################################################

				"Insert to table" )
					#Asks for the table name
					read -p "Enter the table you want to insert to: " table_insert

					#Check if the table exists
					if [[ -f $TablePath/$table_insert ]]
					then
						
						#we used awk for printing the columns number
						LineNumbers=`awk -F :  'END{print NF} ' $TablePath/$table_insert`
						echo "" >>$TablePath/$table_insert
						
                		#Loop iterates around the column number
						for ((i=1 ; i<=$LineNumbers ; i++))
						do
							
							#we used awk to go for each field and we separates fields by :
						    ColumnDatatype=`awk -v i=$i -F : '{print $i}' $TablePath/$table_insert.datatype`
							
							#another awk for iterates each field to print the first value of the line
							awk -v i=$i -F : 'NR==1 {print "Enter the data of column " $i}' $TablePath/$table_insert
							# read value
							#Check if the i value = '1' to identify the primary keys column
							if [[ $i == 1 ]]
						    then
						        echo "You must enter a primary key"
							    read value

								#checks if the value is digits only
								if [[ $value =~ [[:digit:]] ]]
						            then
									#cut the first colummn and grep the value of given primary key
						            cut -f1 -d : $TablePath/$table_insert | grep -x $value
						            
									#Exit status checks if the last command is true to determine if the given primary key exists
									if [[ $? -ne 0 ]]
						            then

						                echo -n "$value:" >> $TablePath/$table_insert
						                continue
						            
									else
						            
									    echo "you have entered existed value, Try again"
						                let i=0
						                continue    
						            
									fi        
						        else
						            
									echo "Please enter digits only"
						            let i=0
						            continue
						        
								fi
						    fi 

							#Check if the Column datatype = String
						    if [[ $ColumnDatatype == "STR" ]]  
						    then
								read value
								#Check if the data is alphabetic?
						        if [[ $value =~ [[:alpha:]] ]]
						        then

						            echo -n "$value">>$TablePath/$table_insert
						        
								else
						        
								    echo "Please enter alphabetic only"
						        	#we use sed to delete the values of line
								    sed -i '$d' $TablePath/$table_insert

									#we use this sed for deleting the empty line
						            sed -i '/^$/d' $TablePath/$table_insert
						            break
						        
								fi

						    else

								#Check if the column data type is integer
						   		 if [[ $ColumnDatatype == "INT" ]]  
									then
										read value
									#Check if the value has entered is integer
						   		     if [[ $value =~ [[:digit:]] ]]
						   		     then
						   		         echo -n "$value">>$TablePath/$table_insert
						   		     else
						   		         echo "Please enter digits only"

						   		     	#we use sed to delete the values of line
						   		         sed -i '$d' $TablePath/$table_insert

											#we use this sed for deleting the empty line
						   		         sed -i '/^$/d' $TablePath/$table_insert
						   		         break
						   		     fi
								fi
						   	fi
							#Check if i not equals the columns number we put : as the field separator
						    if [[ $i -ne $LineNumbers ]]
						    then
						        echo -n ":" >>$TablePath/$table_insert
						    fi

						done
					
					else 
						echo "Table not found"
					fi
					;;




####################################################################################################################################################################





				"Select Table" )
				
				
					read -p "Enter the table you want to select: " select_table
				
				
					#check if the file exist
					if [[ -f $TablePath/$select_table ]]
					then
						#menu of the select options
				
				
				
					    select menu in "select all records" "select record" "select column"
					    do
				
				
				
					        case $menu in
				
				
								#show the entire table
					            "select all records" )
					            
								cat $TablePath/$select_table
					            ;;
				
				
								#select a record using the primary key of the row
					            "select record" )
					            read -p "Please enter the Primary Key: " PK
				
								#check if the primary key exist in the first column only
					            cut -f1 -d : $TablePath/$select_table | grep -x $PK >/dev/null
				
				
					            if [[ $? -eq 0 ]]
					    		then

					                #print the whole row in case the primary key matches 
					                awk -F : -v key=$PK '$1 == key { print $0 }' $TablePath/$select_table
					    		
								else
					            
								    echo "Sry there is no a primary key with value $PK"
					    		
								fi        
					            ;;

				
					            "select column" )
 
					                read -p "Please enter name of the column you want to select: " select_column
									
									#Check if the  selected column exists in the first line or not					                
									head -1 $TablePath/$select_table | grep  $select_column 	
					              	
									#Check if the last command true or false
								    if [[ $? -eq 0 ]]
					                then
									
										echo "*"
										sleep 1
									
										echo "**"
										sleep 1
									
										echo "***"
										sleep 1

										#awk takes the column name to get the column number by loop on NF and pass the field number to Selected_column variable			                	
										selected_column_number=`awk -F : -v name=$select_column '{for (i=1;i<=NF;i++) if ($i==name) print i; exit}' $TablePath/$select_table`

										#prints the column that matches  with column name user entered
										cut -d : -f $selected_column_number $TablePath/$select_table
					                
									else
					                    echo "Column not found"
					                fi
					            ;;

					            * )
									echo "Invalid answer"

					            ;;
					            esac
					    done
					else
					    echo "File not found"
					fi
					;;
				
				
				
				
################################################################################################################################	
				
				
				
				
				
				
				
				
				
				"Update to table" )
					while true
					do

					    read -p "Enter the table name: " table_name
						
						#check if the file exist
					    
						if [[ -f $TablePath/$table_name ]]
					    then
						
						#show the file to the user to choose the primary key and  the column he want to update
						cat $TablePath/$table_name

						echo ""
						
						read -p "Enter the primary key to reach the row you want to update: " PK
						
						#it checks that the primary key is found in thhe first column or not 
						cut -f1 -d : $TablePath/$table_name | grep -x $PK >/dev/null
						
						#check the last command is true or false
						if [[ $? -eq 0 ]]
						then


							#ask for the column number
						    read -p "Enter the column number reach the column you want to update: " col_num
						
							#identify the row which going to be updated using the given primary key 
						    line_num=`awk -F : -v key=$PK  '$1 == key { print NR}' $TablePath/$table_name`
						
						    read -p "enter the value you want to update: " oldValue
						
						    #check if the value the user want to update is exist
						    awk -F : -v key=$PK '$1==key{print $0} ' $TablePath/$table_name | grep -w $oldValue 
						
							#Check the last command is true or false
						    if [[ $? -eq 0 ]];then

							read -p "Enter the new value: " newValue
							
							#check if the user wants to update in the primary keys column
							if [ $col_num == "1" ]
							then

							
								#check the given primary key exists before or not
							    cut -f $col_num -d : $TablePath/$table_name | grep -x $newValue
							    
								#check the  last command is true or false
								if [[ $? -eq 0 ]]
							    then

									echo "this primary key already exists"

								#it repeats the loop if it exists
								continue
							    
								
								else
									#It substitutes the field chosen with the new value  								
									awk -F : -v key=$PK  '$1 == key { print $0 }' $TablePath/$table_name |sed -i "$line_num s/$oldValue/$newValue/" $TablePath/$table_name
									cat $TablePath/$table_name
									echo ""
									break

							    fi
						    else
						    echo "this primary doesn't exist"

							fi


							#Checks if the old value is alphabetic
							if [[ $oldValue =~ [[:alpha:]] ]]  
					    				then
							    #Check if the data is alphabetic?
					    				if [[ $newValue =~ [[:alpha:]] ]]
					    				then
							    			awk -F : -v key=$PK  '$1 == key { print $0 }' $TablePath/$table_name |sed -i "$line_num s/$oldValue/$newValue/" $TablePath/$table_name
					    					cat $TablePath/$table_name
											echo ""
											break
							   			 else
					    					echo "Please enter alphabetic only"
							    			continue
					    				fi
							fi
							#Checks if the old value  is numerical
							if [[ $oldValue =~ [[:digit:]] ]]  
							    then   
								#Make sure that the new value is numerical
							    if [[ $newValue =~ [[:digit:]] ]]
					    		then
							    	awk -F : -v key=$PK  '$1 == key { print $0 }' $TablePath/$table_name |sed -i "$line_num s/$oldValue/$newValue/" $TablePath/$table_name
							    	cat $TablePath/$table_name
							   		echo ""
							    	break
							    else
					    			echo "Please enter digits only"
							    	continue
							    fi
					    	fi      

						    else
						    echo "the value you want to update doesn't exist "
						    continue

						    fi
						else
						    echo "primary key doesn't exist"
						    continue
						fi

					    else
						echo "this table doesn't exist"
						continue
					    fi
					done
					;;


				*)
					echo "please choose an option from the menu next time"
					
					;;
					esac
				done
				#prints if the user enters a database not found
				else
					echo "Database not found"
				fi
				;;




##################################################################################################################






		"drop" )
			read -p "enter the database you want to delete: " db_delete
			#Check if the Database exist
			if [[ -d $myPath/$db_delete ]]
			then
				read -p "are you sure that you want to delete $db_delete [Y/N]?: " answer
				#Check if the user enters Y or y
				if [[ $answer =~ [Yy] ]]
				then
					rm -rf $myPath/$db_delete
				#Check if the user enters N or n 
				elif [[ $answer =~ [Nn] ]]
				then
					echo "file $db_delete didn't deleted"
				else
					echo "Please enter Y/y or N/n only"
				fi	
			else
				echo "Database not exists"
			fi
			;;
		"exit")
			exit
			;;
		*)
			echo "Invalid option"
			;;
		esac 
done
