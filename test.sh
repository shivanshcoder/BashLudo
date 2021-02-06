# #!/bin/bash

# while read -sn1 key # 1 char (not delimiter), silent
# do

#   read -sn1 -t 0.0001 k1 # This grabs all three symbols 
#   read -sn1 -t 0.0001 k2 # and puts them together
#   read -sn1 -t 0.0001 k3 # so you can case their entire input.
#    key+=${k1}${k2}${k3} 

#   case "$key" in
#     $'\e[A'|$'\e0A')  # up arrow
#         ((cur > 1)) && ((cur--))
#         echo up;;

#     $'\e[D'|$'\e0D') # left arrow
#         ((cur > 1)) && ((cur--))
#         echo left;;

#     $'\e[B'|$'\e0B')  # down arrow
#         ((cur < $#-1)) && ((cur++))
#         echo down;;

#     $'\e[C'|$'\e0C')  # right arrow
#         ((cur < $#-1)) && ((cur++))
#         echo right;;

#     $'\e[1~'|$'\e0H'|$'\e[H')  # home key:
#         cur=0
#         echo home;;

#     $'\e[4~'|$'\e0F'|$'\e[F')  # end key:
#         ((cur=$#-1))
#         echo end;;

#     "")   # Space or Enter Key
#         echo space;;

#     q) # q: quit
#         echo Bye!
#         exit;;

#    esac    

                 

# done

# source keyboard.sh
# echo "↕"
# index=0

# mylist=(red blue green yellow)
# colors=(41 44 42 43)

# tput civis      -- invisible
# while true; do

#     printf "\e[20;10H\e[30;${colors[$index]}m      "
#     printf "\e[20;10H\e[30;${colors[$index]}m${mylist[$index]}"
#     printf "\e[20;9H↕"
#     # printf "\e[0;0H\e[30;${colors[$index]}${mylist[$index]}m\e[0m;"
#     key=$(keyboard_handler)
#     # echo "$key"
#     if [[  $key == "up" ]] ; then
#         index=$((index+1))
#     fi

#     if [[  $key == "down" ]] ; then
#         index=$((index-1))
#     fi
#     if [[ $key == "quit" ]]; then
#         break;
#     fi
#     index=$((index%4))
# done

# tput cnorm   -- normal




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

dice_f[6]=$" ----- \e[7D\e[1B|$ $ $|\e[7D\e[1B|     |\e[7D\e[1B|$ $ $|\e[7D\e[1B ----- "
dice_f[5]=$" ----- \e[7D\e[1B|$   $|\e[7D\e[1B|  $  |\e[7D\e[1B|$   $|\e[7D\e[1B ----- "
dice_f[4]=$" ----- \e[7D\e[1B|$   $|\e[7D\e[1B|     |\e[7D\e[1B|$   $|\e[7D\e[1B ----- "
dice_f[3]=$" ----- \e[7D\e[1B|$    |\e[7D\e[1B|  $  |\e[7D\e[1B|    $|\e[7D\e[1B ----- "
dice_f[2]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|$   $|\e[7D\e[1B|     |\e[7D\e[1B ----- "
dice_f[1]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|  $  |\e[7D\e[1B|     |\e[7D\e[1B ----- "
dice_f[0]=$" ----- \e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B|\e[7m     \e[0m|\e[7D\e[1B ----- "
dice_f[0]=$" ----- \e[7D\e[1B|     |\e[7D\e[1B|     |\e[7D\e[1B|     |\e[7D\e[1B ----- "
# \e[7m     \e[0m


clear

# while true; do
#     color=$((39 + RANDOM  % 7))
#     printf "\e[1;1H\e[${color}m     \e[0m"
#     sleep 0.4
# done
read s

i=1
print.boxx "1;1" 7 5
while true; do
    printf "\e[2;2H${dice_f[$i]}"
    # read s
    i=$(($i+1))
    i=$((i%7))
    # i=$((1 + RANDOM % 7))

    sleep 0.03
    printf "\e[2;2H\e[7m${dice_f[0]}\e[0m"
    sleep 0.06
    # read s

done

