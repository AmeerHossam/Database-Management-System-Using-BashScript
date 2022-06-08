# Database Management System

### Implementing Database Management System using BashScript.
![My image](https://camo.githubusercontent.com/4c85765ee3c4f1446fb7a88b7d74c3cfcfbcc3c4b5a9123281ff3c3821ab6524/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6669742f632f313833382f3535312f312a76346f3241584c494a6148535a6d71595a6b323671412e6a706567)

# What does our project do ?
- #### It creates a databases , so you can create a lot of tables inside them.
- #### from the concept of database management system , We can (Create,Delete,Update,Read) the content of the tables
- #### also each table has a primary key , and this primary key has the power of updating and deleting from tables.



## Configuration

To run the script ,you only need to change the path to your own path.

```bash
#Like here I changed to my own path
myPath=/home/amir/Database
#For windows OS Try to replace "/" with "\" and ensure that bash is installed on your system
```
## Run the script

```bash
# 1st: you need to change the permission of the file to read and execute permissions
sudo chmod 500 script.sh
# 2nd: Run the script
./script.sh
```

## Usage

```bash
#1st: Enter your choice
1) create
2) list
3) connect
4) drop
5) exit
```
### Create

```bash
# HINT YOU MUST ENTER STRING ONLY OR ALPHANUMERIC VALUES
1) create
2) list
3) connect
4) drop
5) exit
#? 1
enter the database name(string only): DataBase22
DataBase created
```
```bash
# if you enter an integer value as an input
# It asks you to enter an input again
1) create
2) list
3) connect
4) drop
5) exit
#? 1
enter the database name(string only): 222
Invalid input
enter the database name(string only): 
```

### List
```bash
#If you entered 2 , It lists all databases created in your own path
1) create
2) list
3) connect
4) drop
5) exit
#? 2
DataBase22
#? 
```
### Connect
Here you connect to the database you created , for example: we're going to connect to "DataBase22" that we created
```bash
#It takes us to another window to (create,update,read,delete) tables
Please enter the database name you want to connect: DataBase22
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 
```

### Create Table
Here we're going to create a table so it asks you the name of the table and the number of the table's column (YOU ONLY HAVE TO CHOICE BETWEEN 2 DATATYPES "INT" AND "STR")
```bash
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 1
Enter the table name: Table1
#Here for example I created a table called (Table1)
Enter table columns number: 3
#and the table has 3 columns , next I entered the datatype of each column
-------Note-------
First column is primary key
Enter the column 1 datatype[STR/INT]: int
Enter the column number 1 name : id
Enter the column 2 datatype[STR/INT]: str
Enter the column number 2 name : name
Enter the column 3 datatype[STR/INT]: int
Enter the column number 3 name : age
#? 
```
### List Table
The script creates 2 files , one for the column's datatypes and one for the data of each column so if I listed the tables , 2 tables will be shown , In our case "Table1.datatype" and "Table1"

```bash
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 2
Table1
Table1.datatype
#? 
```
### Insert to Table
Here we're going to insert data to the table we're created, in our case "Table1"
```bash
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 5
Enter the table you want to insert to: Table1
Enter the data of column id
You must enter a primary key
1
Enter the data of column name
Amir
Enter the data of column age
25
```

### Select Table
In Select Table choice we have 3 choices
```bash
Please enter the database name you want to connect: DataBase22
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 6
Enter the table you want to select: Table1
1) select all records
2) select record
3) select column
```
- #### First one is to show all content of the table:
```bash
Enter the table you want to select: Table1
1) select all records
2) select record
3) select column
#? 1
id:name:age
1:Amir:25
```

- #### Second one is to print data with the specific primary key , for example:
```bash
1) select all records
2) select record
3) select column
#? 2
Please enter the Primary Key: 1
1:Amir:25
```

- #### Third one is to print the data of a specific column, for example:

```bash
Enter the table you want to select: Table1
1) select all records
2) select record
3) select column
#? 3
Please enter name of the column you want to select: name
id:name:age
name
Amir
#? 
```
### Update Table
Here we're going to update data inserted to the table

```bash
Please enter the database name you want to connect: DataBase22
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 7
Enter the table name: Table1
id:name:age
1:Amir:25
Enter the primary key to reach the row you want to update: 1
Enter the column number reach the column you want to update: 2
enter the value you want to update: Amir
1:Amir:25
Enter the new value: Omar
id:name:age
1:Omar:25
#? 
```
### Drop from Table
Here we're going to delete the full data of a specific primary key , for example:
```bash
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 4
enter the table name you want to delete from: Table1
enter the pk of row you want to delete: 1
the row is deleted
#? 
```
To ensure  that the data has been deleted so we are going to show the full content of the table by Select choice:
```bash
#? 6
Enter the table you want to select: Table1
1) select all records
2) select record
3) select column
#? 1
id:name:age

```

### Drop table
In this case we are going to delete the table from our database , for example:
```bash
1) Create Table	      4) Delete from Table  7) Update to table
2) List Table	      5) Insert to table
3) Drop Table	      6) Select Table
#? 3
Please enter the DB table you want to remove: Table1
rm: remove regular file '/home/amir/Database/DataBase22/Table1'? yes
rm: remove regular file '/home/amir/Database/DataBase22/Table1.datatype'? yes
#? 2
#? 
```
"See when we entered "2" which for listing all tables in our database , It prints nothing "

### Let's get back to our first menu ,,,
```bash
1) create
2) list
3) connect
4) drop
5) exit
```
## Lets try to drop our database,,,

```bash
1) create
2) list
3) connect
4) drop
5) exit
#? 4
enter the database you want to delete: DataBase22
are you sure that you want to delete DataBase22 [Y/N]?: y
#? 2
#? 
```
"The same concept of deleting table , we dropped it and checked it by entering "2" for list all databases created in my system.

## Feel free to commit changes to the project , I would be appreciated

## Buy me a coffee 😂 ☕ 💋
[![name](https://images.squarespace-cdn.com/content/v1/5f37730c8629cb7bcb427cf0/1643676960373-PJZ13HQF81SDHO5Y2XEQ/bmac.jpg)](https://www.buymeacoffee.com/amirhossam)

## Teams
- #### Amir HossamEldien
- #### Abdulrahman Mostafa
## License
[MIT](https://github.com/AmeerHossam/Database-Management-System-Using-BashScript/blob/4a7bab767897973ce6bb7163ee051426f0fe5e87/LICENSE)
