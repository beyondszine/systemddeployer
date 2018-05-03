#!/bin/bash

myServiceName=$1.service
myFileName=$2
myDescription=$3
myTarget=$4

function createFile(){
	touch $1
}


function addUnit(){
	echo "["$1"]" >> $myServiceName
}

function addElement(){
	echo $1"="$2 >> $myServiceName
}

function serviceCmd(){
	sudo systemctl $1 $myServiceName

}

function deployService(){
	sudo cp $myServiceName "/lib/systemd/system/"
}

createFile $myServiceName
addUnit Unit
addElement Description "$myDescription"
addUnit Service
addElement ExecStart "$myFileName"
addElement StandardOutput null
addUnit Install
addElement WantedBy "$myTarget"
addElement Alias "$myServiceName"
deployService 
serviceCmd "enable"
serviceCmd "start"
serviceCmd "status"
