#!/bin/bash

currentVersion="0.0.1"

function singleDowload() {

        response=$(curl --progress-bar https://transfer.sh/$(basename "$2")/$(basename "$1") -o "$3/$1")

    }

    function printDownloadResponse(){
         singleDowload $1 $2 $3 
         echo "Success!"  
    }

    while getopts "d:hv" flag; do
        case $flag in
    d) echo "Downloading $4" 
               printDownloadResponse $4 $3 $2
              ;;
    h) echo "Description: Bash tool to transfer files from the command line.
           Usage:
             -d  ...
             -h  Show the help ... 
             -v  Get the tool version
           Examples:
               ./transfer.sh test.txt .. ./transfer.sh -d ./test Mij6ca test.txt";;
        v) echo "0.0.1";;
          
        esac
    done


    
    if [[ $1 != '-d' && $1 != '-v' &&  $1 != '-h' ]]
    then
        for i in "$@"
            do
                echo "Uploading $i"
                response=$(curl --progress-bar --upload-file "$i" https://transfer.sh/$(basename "$i"));
                echo "Transfer File URL: $response"
            done
    fi
