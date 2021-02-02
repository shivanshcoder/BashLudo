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

source keyboard.sh
echo "↕"
index=0

mylist=(red blue green yellow)
colors=(41 44 42 43)

tput civis      -- invisible
while true; do

    printf "\e[20;10H\e[30;${colors[$index]}m      "
    printf "\e[20;10H\e[30;${colors[$index]}m${mylist[$index]}"
    printf "\e[20;9H↕"
    # printf "\e[0;0H\e[30;${colors[$index]}${mylist[$index]}m\e[0m;"
    key=$(keyboard_handler)
    # echo "$key"
    if [[  $key == "up" ]] ; then
        index=$((index+1))
    fi

    if [[  $key == "down" ]] ; then
        index=$((index-1))
    fi
    if [[ $key == "quit" ]]; then
        break;
    fi
    index=$((index%4))
done

tput cnorm   -- normal




##########################
