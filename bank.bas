#include "file.bi"
const program="mousepad"
const report="report.txt"
const dirs="./database"
const names="./database/bank.dat"
const sqlite="sqlite3 "+names
const nulll=" 2> /dev/null"
const separeter="--------------------------------"
const menu=!"zenity --title=menu --height=350 --width=600 --list --text=menu --separator=, --column=menu \"add bank\" \"delete bank and moves\" \"exit\" \"find bank\" \"list bank\" \"add moves\" \"list moves\" \"delete moves\" "+nulll
const calender="zenity --calendar --date-format=%y/%m/%d "+nulll
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
	Open Pipe calender For input As #4
		line input #4,b
		do
			if eof(4) then exit do
			line input #4,mm
		loop
		line input #4,mm
		line input #4,mm
	close 4
		do
			m=inkey()
			if m="" then exit do
			
		loop
		
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
	Open Pipe menu For input As #4
		line input #4,a
		do
			if eof(4) then exit do
			line input #4,b
		loop
	close 4
	if a="exit" then end 
		do
			b=inkey()
			if b="" then exit do
			
		loop

	if a="add bank" then add
	if a="delete bank and moves" then deletes
	if a="list bank" then list
	if a="find bank" then finds
	if a="add moves" then moves
	if a="list moves" then reports
	if a="delete moves" then deletesmoves

loop
