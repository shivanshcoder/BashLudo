# #!/bin/bash

##########################

horzLine(){
    # printf "\e[47m\e[${1}H"
    printf "\e[47m"
    for ((i=0;i<$1;i++));do
        printf " "
    done
    printf "\e[0m"
}
vertLine(){
    # printf "\e[47m\e[${1}H"
    printf "\e[47m"
    for ((i=0;i<$1;i++));do
        printf " \e[1B\e[1D"
    done
    printf "\e[0m"
}

print.boxx(){
    coords=$1
    width=$2
    height=$3

    printf "\e[${coords}H"
    horzLine $width

    printf "\e[1D"
    vertLine $height

    printf "\e[${coords}H"
    vertLine $height

    printf "\e[1A"
    horzLine $width

}


# print.boxx "2;2" 5 3
declare -A dice_f

dice_f[6]=$"$ $ $\e[5D\e[1B     \e[5D\e[1B$ $ $\e[5D\e[1B"
dice_f[5]=$"$   $\e[5D\e[1B  $  \e[5D\e[1B$   $\e[5D\e[1B"
dice_f[4]=$"$   $\e[5D\e[1B     \e[5D\e[1B$   $\e[5D\e[1B"
dice_f[3]=$"$    \e[5D\e[1B  $  \e[5D\e[1B    $\e[5D\e[1B"
dice_f[2]=$"     \e[5D\e[1B$   $\e[5D\e[1B     \e[5D\e[1B"
dice_f[1]=$"     \e[5D\e[1B  $  \e[5D\e[1B     \e[5D\e[1B"
dice_f[0]=$"     \e[5D\e[1B     \e[5D\e[1B     \e[5D\e[1B"

# dice_f[0]=$" ----- \e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B ----- "

# dice_f[6]=$" ----- \e[7D\e[1B|$ $ $|\e[7D\e[1B|     |\e[7D\e[1B|$ $ $|\e[7D\e[1B ----- "
# dice_f[5]=$" ----- \e[7D\e[1B|$   $|\e[7D\e[1B|  $  |\e[7D\e[1B|$   $|\e[7D\e[1B ----- "
# dice_f[4]=$" ----- \e[7D\e[1B|$   $|\e[7D\e[1B|     |\e[7D\e[1B|$   $|\e[7D\e[1B ----- "
# dice_f[3]=$" ----- \e[7D\e[1B|$    |\e[7D\e[1B|  $  |\e[7D\e[1B|    $|\e[7D\e[1B ----- "
# dice_f[2]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|$   $|\e[7D\e[1B|     |\e[7D\e[1B ----- "
# dice_f[1]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|  $  |\e[7D\e[1B|     |\e[7D\e[1B ----- "
# dice_f[0]=$" ----- \e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B ----- "
# dice_f[0]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|     |\e[7D\e[1B|     |\e[7D\e[1B ----- "
# \e[7m     \e[0m


clear


i=1
# print.boxx "1;1" 7 5

print_place="5;5"

# while true; do
#     printf "\e[${print_place}H${dice_f[$i]}"
#     # read s
#     i=$(($i+1))
#     i=$((i%7))
#     # i=$((1 + RANDOM % 7))

#     sleep 0.04
#     printf "\e[${print_place}H\e[7m${dice_f[0]}\e[0m"
#     sleep 0.08
#     # read s

# done


dice.roll(){
    dice_val=0
    
    # Gets a random number from 1 - 6
    dice_val=$((1 + RANDOM % 6));

    for i in {1..10}; do
        j=$((1+RANDOM%6))
        printf "\e[${print_place}H${dice_f[$j]}"
        sleep 0.04
        printf "\e[${print_place}H\e[7m${dice_f[0]}\e[0m"
        sleep 0.08

    done
    printf "\e[${print_place}H${dice_f[$dice_val]}"
}

funct(){
    val=$1
    limit=$2

    val=$(( $val + $3 ))
    val=$(( $val % $limit ))
    echo $val
}

get.dice_val(){
    if [[ $dice_val -eq 0 ]]; then

        dice_val=${dice_values:0:1}
        dice_values=${dice_values:1}

        if [[ -z $dice_val ]]; then
            # We don't get any dice_value
            # Make the dice_val arbitary big value
            dice_val=100
        fi
    fi
}
dice_val=0
check.move.possibility(){
    dice_values=$1 #"664"
    shift
    local pieces=( 6 6 1 4)
    local pieces=($@)

    get.dice_val

    local index=0
    
    for i in {0..3}; do
        piece=${pieces[$i]}
        while [[ $piece -ge ${dice_values:0:1} ]]; do
            piece=$(($piece - $dice_val))
            dice_val=0
            get.dice_val
        done
        get.dice_val

        pieces[$i]=$piece
    done

    if [[ -z "$dice_val$dice_values" ]]; then
        echo "VALID"
    else
        echo "INVALID"
    fi
}


check.move.possibility $@