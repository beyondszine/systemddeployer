#!/bin/bash


function showUsage() {
	echo "-----------------------"
	echo "-----------------------"
	echo "-----------------------"
	echo "-----------------------"
}

function printVariables(){
	echo $myServiceName
	echo $myFileName
	echo $myDescription
	echo $myTarget
}


if [ $# -lt 1 ]
then
	echo "Error! Not enough number of args!"
	showUsage
	exit 1
fi


while getopts ":hf:s:d:t:" opt;
do
  case ${opt} in
    h )
			echo "-h Used for help"
			showUsage
			exit 1
      ;;
    t )
			myTarget=$OPTARG
			# echo $OPTARG
      ;;
		f )
			myFileName=$OPTARG
			# echo $OPTARG
      ;;
		s )
			myServiceName=$OPTARG.service
			# echo $OPTARG
      ;;
		d )
			myDescription=$OPTARG
			# echo $OPTARG
      ;;
    \? )
		 	echo "Usage: cmd [-h] [-t]..."
      ;;
		: )
      echo "Invalid option: $OPTARG requires an argument"
      ;;
		* )
			echo "bad option!!"
		 ;;
  esac
done
shift $((OPTIND -1))
printVariables

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
	echo "Command Recieved: "$1
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
serviceCmd "stop"
serviceCmd "disable"
