
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
    
    printf "\e[13;13HUsing Arrows choose the desired color"
    printf "\e[14;13HPress e to edit a player name"
    printf "\e[15;18HCurrently Selected color"

}


declare -A names

game.menu(){

    local positions=("3;5" "3;41" "21;5" "21;41")
    local icons=("$Ludo_L" "$Ludo_U" "$Ludo_D" "$Ludo_O")

    for i in {0..3}; do
        printf "\e[${positions[$i]}H${icons[$i]}"
    done
    #             yellow       blue          green         red

    # local names=("Not Playing" "Not Playing" "Not Playing" "Not Playing")
    local player_colors=(y b g r)

    instructions

    local cursor_pos=("7;11" "7;47" "25;11" "25;47")
    local index=0
    local curr_color=${player_colors[$index]}

    old_index=0
    printf "\e[5m\e[${positions[$index]}H${icons[$index]}"

    printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
    printf "\e[16;18HPlayer Name: ${names[$curr_color]:-NotPlaying}"

    while true; do
        key=$(keyboard_handler)

        case "$key" in 

            ":right")
                index=$(increment.limit $index 4 1) 
                curr_color=${player_colors[$index]}
                ;;

            ":left")
                index=$(increment.limit $index 4 -1) 
                curr_color=${player_colors[$index]}
                ;;

            s)

                break;;


            e)

                printf "\e[16;16H                                  "
                printf "\e[16;18HPlease Enter Name: "
                # printf "\e[${cursor_pos[$old_index]}H"
                printf "\e[0m\e[7m"
                read the_name
                printf "\e[0m"
                names[$curr_color]=$the_name

        esac

        if [[ $index -ne $old_index ]]; then

            printf "\e[${positions[$old_index]}H${icons[$old_index]}"
            printf "\e[${cursor_pos[$old_index]}H   "
            printf "\e[16;16H                                          "

            printf "\e[5m\e[${positions[$index]}H${icons[$index]}"
            printf "\e[${cursor_pos[$index]}H\e[5;7m(=)\e[0m"
            printf "\e[16;18HPlayer Name: ${names[$curr_color]:-NotPlaying}"
        fi

        old_index=$index
    done
}



game.end(){
    print.ludo 
    printf "\e[15;22H Player $1 won"
    printf "\e[16;17H Thank you for playing Ludo"
    printf "\e[17;22H Y to play again"
    printf "\e[18;23H N to end game"

    while true; do
        key=$(keyboard_handler)

        case "$key" in 
            "y" | "Y")
                game.start
                break
            ;;

            "n"| "N")
                clear
                stty echo
                tput cnorm -- normal
                echo "Game Ended"
                break
            ;;
        esac
    done
}

source board.sh


game.start(){


    # print the menu
    game.menu

    tput civis -- invisible
    stty -echo

    # start the game
    game ${!names[@]}

    if [[ -n $exit_condi ]]; then
        clear
        stty echo
        tput cnorm -- normal
        echo "Forcefully quit game"
        return 1
    fi

    # Get the name of the player that finished first
    game.end ${names[finished_players[0]]}


}

clear

game.start


