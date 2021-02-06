
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
source keyboard.sh




game.start(){

    positions=("3;5" "3;41" "21;5" "21;41")
    icons=("$Ludo_L" "$Ludo_U" "$Ludo_D" "$Ludo_O")

    for i in {0..3}; do
        printf "\e[${positions[$i]}H${icons[$i]}"
    done

    instructions

    # cursor_pos=("7;12" "7;48" "25;12" "25;48")
    cursor_pos=("7;9" "7;45" "25;9" "25;45")
    index=0

    old_index=0
    printf "\e[5m\e[${positions[$index]}H${icons[$index]}"

    # printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
    printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"

    while true; do
        key=$(keyboard_handler)

        case "$key" in 

            ":right")
                index=$((index+1));;

            ":left")
                index=$((index-1));;

            # ":back")
            #     echo "BACKSPACE";;
                
            [a-zA-Z]*)
                echo "$key";;

            ":quit")
                break;;
        esac

        index=$((index%4))
        if [[ $index -ne $old_index ]]; then

            printf "\e[${positions[$old_index]}H${icons[$old_index]}"
            printf "\e[${cursor_pos[$old_index]}H   "

            printf "\e[5m\e[${positions[$index]}H${icons[$index]}"
            printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
        fi

        old_index=$index
    done


    # while true; do
#     key=$(keyboard_handler)
#     echo "This was pressed:  $key"
#     if [[  $key == "Bye!" ]]; then
#         break;
#     fi
# done
}
clear
game.start
# printf "\e[5m\e[3;5H$Ludo_L"
# read 
# printf "\e[3;5H$Ludo_L"