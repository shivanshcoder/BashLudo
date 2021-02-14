#!/bin/bash

# Snippet from 
# https://stackoverflow.com/a/56200043

# Function to read the input and prints the key that was pressed
# Should be used with $(...) to capture the output
keyboard_handler(){
    read -sn1 key

    read -sn1 -t 0.0001 k1 # This grabs all three symbols 
    read -sn1 -t 0.0001 k2 # and puts them together
    read -sn1 -t 0.0001 k3 # so you can case their entire input.
    key+=${k1}${k2}${k3}
    case "$key" in
        $'\e[A'|$'\e0A')  # up arrow
           ((cur > 1)) && ((cur--))
            echo :up;;

        $'\e[D'|$'\e0D') # left arrow
            ((cur > 1)) && ((cur--))
            echo :left;;

        $'\e[B'|$'\e0B')  # down arrow
            ((cur < $#-1)) && ((cur++))
            echo :down;;

        $'\e[C'|$'\e0C')  # right arrow
            ((cur < $#-1)) && ((cur++))
            echo :right;;

        # $'\e[1~'|$'\e0H'|$'\e[H')  # home key:
        #     cur=0
        #     home.key
        #     echo home;;

        # $'\e[4~'|$'\e0F'|$'\e[F')  # end key:
        #     ((cur=$#-1))
            
        #     echo end;;

        
        $'\e[H')
            echo :back;;

        $"")   # Space or Enter Key
            echo :space;;

        [a-zA-Z])
            echo $key;;

        # q) # q: quit
        #     # quit.key
        #     echo :quit
        #     # exit;;

    esac    

}

increment.limit(){
    val=$1
    limit=$2
    increment_value=$3

    val=$(( $val + $increment_value ))
    val=$(( $val % $limit ))
    echo $val
}



declare -A dice_f

dice_f[6]=$"$ $ $\e[5D\e[1B     \e[5D\e[1B$ $ $\e[5D\e[1B"
dice_f[5]=$"$   $\e[5D\e[1B  $  \e[5D\e[1B$   $\e[5D\e[1B"
dice_f[4]=$"$   $\e[5D\e[1B     \e[5D\e[1B$   $\e[5D\e[1B"
dice_f[3]=$"$    \e[5D\e[1B  $  \e[5D\e[1B    $\e[5D\e[1B"
dice_f[2]=$"     \e[5D\e[1B$   $\e[5D\e[1B     \e[5D\e[1B"
dice_f[1]=$"     \e[5D\e[1B  $  \e[5D\e[1B     \e[5D\e[1B"
dice_f[0]=$"     \e[5D\e[1B     \e[5D\e[1B     \e[5D\e[1B"

dice_values=""

dice.roll(){
    print_place="15;29"

    dice_val=0
    
    # Gets a random number from 1 - 6
    dice_val=$((1 + RANDOM % 6));
    dice_values="$dice_values$dice_val"

    for i in {1..10}; do
        j=$((1+RANDOM%6))
        printf "\e[${1}m"
        printf "\e[${print_place}H${dice_f[$j]}"
        printf "\e[0m" 
        sleep 0.04
        printf "\e[${print_place}H${dice_f[0]}\e[0m"
        sleep 0.08
    done

    printf "\e[${1}m\e[${print_place}H${dice_f[$dice_val]}\e[0m"
}


ludo.dice.roll(){
    
    dice_values=""
    dice_val=6

    while [[ $dice_val -eq 6 ]]; do
        # $1 is the color of the player ( r g b y)
        dice.roll ${colors[$1]}

        #sleep 2
        if [[ $dice_values == "666" ]]; then
            dice_values=""
            # If we get 6 in a row, should skip the turn
            break;
        fi
    done
}

