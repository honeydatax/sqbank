#include "file.bi"
const program="nano"
const report="report.txt"
const dirs="./database"
const names="./database/bank.dat"
const sqlite="sqlite3 "+names
const nulll=" 2> /dev/null"
const errors=" 2> "+"report.txt"
const separeter="--------------------------------"
const menu=!"dialog --menu \"menu\" 16 60 7 \"add bank\" \"add bank\" \"delete bank and moves\" \"delete bank and moves\" \"exit\" \"exit\" \"find bank\" \"find bank\" \"list bank\" \"list bank\" \"add moves\" \"add moves\" \"list moves\" \"list moves\" \"delete moves\" \"delete moves\" "+errors
const calender=!"dialog --inputbox yy-mm-dd 60 \"\" "+errors
sub deletesmoves()
	dim a as integer
	dim b as string
	dim c as string
	dim d as double
	dim e as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
	cls
		print "bank ID: ";
		input a
	
		Open Pipe sqlite +" -header -column  > " + report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks where ID ="+str(a)+";"
			print #1,".width 16 16 10 25 16 "
			print #1,"select * from moves where bank ="+str(a)+" order by date ;"
			print #1,";"
			print #1,".quit"
		close 1
		shell program +" "+report + nulll
		do
				print "type -1 to exit"
				print "move ID to delete : ";
				input b
				if b="-1" then exit sub
			Open Pipe sqlite +" -header -column  "  For output As #1
				print #1,".width 16 16 10 25 16 "
				print #1,"select * from moves where ID ="+b+" order by date;"
				print #1,"delete from moves where ID ="+b+";"
				print #1,";"
				print #1,".quit"
			close 1
	loop
end sub 
sub deletes()
	dim a as integer
	dim b as string
	dim c as string
	dim d as double
	dim e as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
	cls
		print "bank ID: ";
		input a
	
		Open Pipe sqlite +" -header -column  " For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks where ID ="+str(a)+";"
			print #1,"delete from moves where bank ="+str(a)+";"
			print #1,"delete from banks where ID ="+str(a)+";"
			print #1,";"
			print #1,".quit"
		close 1
		Open Pipe sqlite +" -header -column  > " +report For output As #1
			print #1,".width 16 25 25 25 25 25 25"
			print #1,"select * from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report +nulll
end sub 
sub reports()
	dim a as integer
	dim b as string
	dim c as string
	dim d as double
	dim e as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
	cls
		print "bank ID: ";
		input a
	
		Open Pipe sqlite +" -header -column  > " +report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks where ID ="+str(a)+";"
			print #1,".width 16 16 10 25 16 "
			print #1,"select * from moves where bank ="+str(a)+" order by date;"
			print #1,"select sum(value) from moves where bank ="+str(a)+";"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
end sub 
sub moves()
	dim y as integer
	dim x as integer
	dim a as integer
	dim b as string
	dim c as string
	dim d as double
	dim e as string
	dim mm as string
	dim m as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
	cls
		print "bank ID: ";
		input a
	
		Open Pipe sqlite +" -header -column  " For output As #1
			print #1,".width 16 25 "
			print #1,"select ID,name from banks where ID ="+str(a)+";"
			print #1,";"
			print #1,".quit"
		close 1

	print "leave a area of text out to exit"	
	do
		print separeter
		'print "dates yyyy\mm\dd: ";
		'line input b
	shell (calender)
	open report for input as 1
		line input #1,b
	close 1
	cls
		
		if b="" then exit sub
		print "about: ";
	    'x=pos()
		'y=csrlin()
		'locate y,x
		line input c
		if c="" then exit sub
		print "amount - to negative: ";
		input d
		Open Pipe sqlite For output As #1
			print #1,"insert into moves(bank, date,desig,value) values("+str(a)+",'"+b+"','"+c+"',"+str(d)+");"
			print #1,";"
			print #1,".quit"
		close 1
	loop
	
end sub 
sub finds()
	dim a as string
	print "words to find"
	input a
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 25 25 25 25 "
			print #1,"select * from banks where name like '%"+a+"%' order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
end sub
sub list()
	dim a as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 25 25 25 25 "
			print #1,"select * from banks order by name;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + nulll
end sub
sub add()
	dim a as string
	dim b as string
	dim c as string
	dim d as string
	dim e as string
	print "leave a area of text out to exit"
	
	do
		print separeter
		print "name: ";
		line input a
		if a="" then exit sub
		print "addrress: ";
		line input b
		if b="" then exit sub
		print "email: ";
		line input c
		if c="" then exit sub
		print "phone: ";
		line input d
		if d="" then exit sub
		print "about: ";
		line input e
		if e="" then exit sub
		Open Pipe sqlite For output As #1
			print #1,"insert into banks(name,addrress,email,phone,txs) values('"+a+"','"+b+"','"+c+"','"+d+"','"+e+"');"
			print #1,";"
			print #1,".quit"
		close 1
	loop
	
end sub 
sub creates()
	Open Pipe sqlite For output As #1
		print #1,"create table banks(ID INTEGER PRIMARY KEY AUTOINCREMENT , name text(25) not null, addrress text(25) not null, email text(25) not null,phone text(25) not null,txs text(25) not null) ; "
		print #1,"create table moves(ID INTEGER PRIMARY KEY AUTOINCREMENT ,bank integer not null, date text(10) not null, desig text(25) not null, value double not null); "
		print #1,";"
		print #1,".quit"
	close 1
	print "data base create"
end sub

dim a as string
dim b as string
if not (FileExists(dirs)) then mkdir(dirs)
if not (FileExists(names)) then creates()
color 15,5
do
	cls
	shell (menu)
	open report for input as 1
		line input #1,a
	close 1
	cls
	if a="exit" then end 
	if a="add bank" then add
	if a="delete bank and moves" then deletes
	if a="list bank" then list
	if a="find bank" then finds
	if a="add moves" then moves
	if a="list moves" then reports
	if a="delete moves" then deletesmoves

loop
