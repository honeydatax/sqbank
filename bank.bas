#include "file.bi"
const program="mousepad"
const report="report.txt"
const dirs="./database"
const names="./database/bank.dat"
const sqlite="sqlite3 "+names
sub finds()
	dim a as string
	print "words to find"
	input a
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 25 25 25 25 "
			print #1,"select * from banks where name like '"+a+"';"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + " > /dev/null"
end sub
sub list()
	dim a as string
	print "working....."
		Open Pipe sqlite +" -header -column > " + report For output As #1
			print #1,".width 16 25 25 25 25 25 "
			print #1,"select * from banks;"
			print #1,";"
			print #1,".quit"
		close 1
	shell program +" "+report + " > /dev/null"
end sub
sub add()
	dim a as string
	dim b as string
	dim c as string
	dim d as string
	dim e as string
	print "leave a area of text out to exit"
	
	do
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
		if a="" then exit sub
		print "about: ";
		line input e
		if a="" then exit sub
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
		print #1,"create table moves(ID INTEGER PRIMARY KEY AUTOINCREMENT , date text(10) not null, desig text(25) not null, value double not null); "
		print #1,";"
		print #1,".quit"
	close 1
	print "data base create"
end sub

dim a as string
if not (FileExists(dirs)) then mkdir(dirs)
if not (FileExists(names)) then creates()
color 15,5
do
	cls
	print "menu"
	print "add bank			a"
	print "exit				e"
	print "find bank			f"
	print "list bank			l"


	do
		a=inkey()
		if a <>"" then exit do 
	loop
	if a="e" or a="E" then end 
	if a="a" or a="A" then add
	if a="l" or a="L" then list
	if a="f" or a="F" then finds
loop
