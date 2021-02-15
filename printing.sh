#!/bin/bash

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


##################################################

declare -A colors
colors[r]=31
colors[b]=34
colors[g]=32
colors[y]=33


print.box(){
    local color="\e[${colors[$2]}m"

    printf "\e[$1H\e[1A\e[2D" 
    printf "${color}"
    printf "+---+"
    printf "\e[1B\e[5D"
    printf "|   |"
    printf "\e[1B\e[5D"
    printf "+---+\e[0m"
}


print.pawn(){
    # $1 is the color of the pawn
    # $2 is the number of the pawn
    local pos=${pawns[$1:$2:cur_pos]}
    local color_code=${colors[$1]}
    local pawn_char=${pawns[$1:$2:pawn_char]}
    printf "\e[${pos}H\e[1D\e[1;${color_code}m $pawn_char \e[0m"
}

print.pawn.empty(){
   printf "\e[${1}H\e[1D\e[0m   "

}

print.all.pawns(){
    local all_colors=(y b r g)

    for pawn_color in ${all_colors[@]}; do
        for pawn_index in {0..3}; do
            print.pawn $pawn_color $pawn_index
        done
    done 
}

highlight.pawn(){
    printf "\e[5;7m"
    print.pawn $@
    printf "\e[0m"
}

unhighlight.pawn(){
    print.pawn $@
}

####################################