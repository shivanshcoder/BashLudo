#!/bin/bash
# source colors.sh

# print.pawn(){
#     text_color=$2
#     printf "\e[${1}H\e[1D\e[1;${text_color};47m 1 \e[0m"
# }
# print.paw(){
#     text_color=$2
#     printf "\e[${1}H\e[1;${text_color};5;47m$\e[0m"
#     tput cup 0 0
# }


# print.box(){
#     color=$2
#     bgcolor=$3

#     printf "\e[5m\e[$1H\e[1A\e[2D" 
#     printf "$color"
#     printf "+---+"
#     printf "\e[1B\e[5D"
#     printf "|${bgcolor}   \e[0;5m${color}|"
#     printf "\e[1B\e[5D"
#     printf "+---+\e[0m"

#     print.paw $1 $4 $5
# }



# clear

# print.box "10;10" $redfg $redbg 31 
# print.box "15;10" $redfg $yellowbg 33 
# print.box "10;15" $redfg $bluebg 34 
# print.box "15;15" $redfg $greenbg 32 





###################LUDO ICON Colored Strings##########################
Ludo_L_color="\e[33m"
Ludo_L="${Ludo_L_color}+---+       +---+\e[1B\e[17D|   |       |   |\e[1B\e[17D+---+       +---+\e[1B\e[17D |||             \e[1B\e[17D |||             \e[1B\e[17D |||             \e[1B\e[17D+---+       +---+\e[1B\e[17D|   |=======|   |\e[1B\e[17D+---+       +---+\e[0m"

Ludo_U_color="\e[34m"
Ludo_U="${Ludo_U_color}+---+       +---+\e[1B\e[17D|   |       |   |\e[1B\e[17D+---+       +---+\e[1B\e[17D |||         ||| \e[1B\e[17D |||         ||| \e[1B\e[17D \||         ||/ \e[1B\e[17D+---+       +---+\e[1B\e[17D|   |==___==|   |\e[1B\e[17D+---+       +---+\e[0m"

Ludo_D_color="\e[32m"
#                                                             FOR PRINTING Double forward slashes
Ludo_D=$"${Ludo_D_color}+---+       +---+\e[1B\e[17D|   |=====\\\\\|   |\e[1B\e[17D+---+       +---+\e[1B\e[17D |||         |\  \e[1B\e[17D |||         ||) \e[1B\e[17D |||         |/  \e[1B\e[17D+---+       +---+\e[1B\e[17D|   |=====//|   |\e[1B\e[17D+---+       +---+\e[0m"

Ludo_O_color="\e[31m"
Ludo_O="${Ludo_O_color}+---+       +---+\e[1B\e[17D|   |__===__|   |\e[1B\e[17D+---+       +---+\e[1B\e[17D  ||         ||  \e[1B\e[17D |||         ||| \e[1B\e[17D  ||         ||  \e[1B\e[17D+---+       +---+\e[1B\e[17D|   |==___==|   |\e[1B\e[17D+---+       +---+\e[0m"

# printf "\e[5;5H\e[2BHello";
# printf "$Ludo_L"
# read
# printf "$Ludo_U"
# read
# printf "$Ludo_D"
# read
# printf "$Ludo_O"
# read


print.ludo(){
    printf "\e[${1}m\e[3;5H$Ludo_L"
    printf "\e[${1}m\e[3;41H$Ludo_U"
    printf "\e[${1}m\e[21;5H$Ludo_D"
    printf "\e[${1}m\e[21;41H$Ludo_O"
}

############################# END #####################################

instructions(){
    printf "\e[5;30H\e[33mL\e[34mU\e[32mD\e[31mO\e[0m" 
    # printf "\e[6;25H\e[5m(2-4) Players\e[0m"

    # printf "\e[13;20HWelcome To Console Ludo"
    # printf "\e[14;13HThis Game can be played by 2-4 players"
    printf "\e[13;13HUsing Arrows chose the desired color"
    printf "\e[15;18HCurrently Selected color"

    # printf "\e[16;12HBlinking color specifies the selected color"
    # printf "\e[17;12HWhile on a color, you can edit player name,"
    # printf "\e[18;14Hby directly typing using alphabet keys"
}