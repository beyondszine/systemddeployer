#!/bin/bash


myServiceName=$1
myFileName=$2
myDescription=$3
myTarget=$4


function addUnit(){
	echo "["$1"]"
}

function addElement(){
	echo $1"="$2
}

addUnit Unit
addElement Description "$myDescription"
addUnit Service
addElement ExecStart "$myFileName"
addElement StandardOutput null
addUnit Install
addElement WantedBy "$myTarget"
addElement Alias "$myServiceName".service
