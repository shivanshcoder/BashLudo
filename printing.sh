#!/bin/bash
source colors.sh

print.pawn(){
    text_color=$2
    printf "\e[${1}H\e[1D\e[1;${text_color};47m 1 \e[0m"
}
print.paw(){
    text_color=$2
    printf "\e[${1}H\e[1;${text_color};5;47m$\e[0m"
    tput cup 0 0
}


print.box(){
    color=$2
    bgcolor=$3

    printf "\e[5m\e[$1H\e[1A\e[2D" 
    printf "$color"
    printf "+---+"
    printf "\e[1B\e[5D"
    printf "|${bgcolor}   \e[0;5m${color}|"
    printf "\e[1B\e[5D"
    printf "+---+\e[0m"

    print.paw $1 $4 $5
}



clear

print.box "10;10" $redfg $redbg 31 
print.box "15;10" $redfg $yellowbg 33 
print.box "10;15" $redfg $bluebg 34 
print.box "15;15" $redfg $greenbg 32 

