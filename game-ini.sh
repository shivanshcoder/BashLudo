
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

game.start(){

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


menu.select(){
    val=1
    while true; do

        read -s -n 1 key
        printf "\e[1;1H$val"
        val=$val+1
        val=$val


}