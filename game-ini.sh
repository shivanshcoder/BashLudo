
#!/bin/bash

#Global Game Variables

# Game keeps running till this variable has value no
exit_game=no

# Custom function return value storage global variables
# Functions which return some value set value of this variable
function_return_val=0

my.select(){
    # error_msg=$1
    # shift

    select os in $@
    do
    if [[ -n $os ]]; then
        echo $os
        exit_game=$os
        break;
    else
        echo "Invalid Answer"
    fi
done
}

game.start.old(){

    while true; do

        printf "\nWelcome to Ludo Game"
        printf "\nHow many players are going to play (2-4)\n"
        read num_players

        if  [[ $num_players -gt 4 ]] || [[ $num_players -lt 2 ]]; then
            printf "Players can be between 2 to 4 only"
        else 
            break
        fi
    done
}



game(){
    printf "GAME"
}



game.loop(){

    while true; do

        # Clear the screen to start fresh
        clear

        # Setup before starting the game
        game.start

        # Actual Game is played using this game
        game

        # Exit the game or not
        printf "\n\nExit Game?\n"
        my.select yes no

        if [[ $exit_game -eq "yes" ]]; then
            break;
        fi
    done
}


# game.loop

source printing.sh
source utils.sh

instructions(){
    printf "\e[5;30H\e[33mL\e[34mU\e[32mD\e[31mO\e[0m" 
    # printf "\e[6;25H\e[5m(2-4) Players\e[0m"

    # printf "\e[13;20HWelcome To Console Ludo"
    # printf "\e[14;13HThis Game can be played by 2-4 players"
    printf "\e[13;13HUsing Arrows choose the desired color"
    printf "\e[14;13HPress e to edit a player name"
    printf "\e[15;18HCurrently Selected color"

    # printf "\e[16;12HBlinking color specifies the selected color"
    # printf "\e[17;12HWhile on a color, you can edit player name,"
    # printf "\e[18;14Hby directly typing using alphabet keys"
}



game.menu(){

    local positions=("3;5" "3;41" "21;5" "21;41")
    local icons=("$Ludo_L" "$Ludo_U" "$Ludo_D" "$Ludo_O")

    for i in {0..3}; do
        printf "\e[${positions[$i]}H${icons[$i]}"
    done
    
    local names=("Not Playing" "Not Playing" "Not Playing" "Not Playing")

    instructions

    local cursor_pos=("7;9" "7;45" "25;9" "25;45")
    local index=0

    old_index=0
    printf "\e[5m\e[${positions[$index]}H${icons[$index]}"

    printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
    printf "\e[16;16HPlayer Name: ${names[$index]}"

    while true; do
        key=$(keyboard_handler)

        case "$key" in 

            ":right")
                index=$(increment.limit $index 4 1) 
                ;;

            ":left")
                index=$(increment.limit $index 4 -1) 
                ;;

            q)
                break;;

            e)

                printf "\e[16;16H                                  "
                printf "\e[16;16HPlease Enter Name"
                printf "\e[${cursor_pos[$old_index]}H"
                read -n5 the_name
                names[$index]=$the_name

        esac

        if [[ $index -ne $old_index ]]; then

            printf "\e[${positions[$old_index]}H${icons[$old_index]}"
            printf "\e[${cursor_pos[$old_index]}H   "
            printf "\e[16;16H                                          "

            printf "\e[5m\e[${positions[$index]}H${icons[$index]}"
            printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
            printf "\e[16;16HPlayer Name: ${names[$index]}"
        fi

        old_index=$index
    done
}


clear

game.start(){
    # print Menu
    game.menu

    # Get Player Names
    
    # Start Game

    # Ask if want to play again?
}

# game(){
#     # Start with a Random Player

#     # Let each player do their turns

#     # Whenever all pawns reach end, player wins 
# }

