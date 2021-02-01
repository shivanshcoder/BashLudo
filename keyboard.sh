#!/bin/bash

# up.key(){
#     echo "UP KEY THIS IS"
# }

# # left.key(){}
# # right.key(){}
# # down.key(){}
# # space.enter.key(){}

# keyboard_handler(){


#     while read -sn1 key # 1 char (not delimiter), silent
#     do

#     read -sn1 -t 0.0001 k1 # This grabs all three symbols 
#     read -sn1 -t 0.0001 k2 # and puts them together
#     read -sn1 -t 0.0001 k3 # so you can case their entire input.
#     key+=${k1}${k2}${k3} 

#     case "$key" in
#         $'\e[A'|$'\e0A')  # up arrow
#             #((cur > 1)) && ((cur--))
            
#             up.key
#             echo up;;

#         $'\e[D'|$'\e0D') # left arrow
#             #((cur > 1)) && ((cur--))
#             left.key
#             echo left;;

#         $'\e[B'|$'\e0B')  # down arrow
#             #((cur < $#-1)) && ((cur++))
#             down.key
#             echo down;;

#         $'\e[C'|$'\e0C')  # right arrow
#             #((cur < $#-1)) && ((cur++))
#             right.key
#             echo right;;

#         # $'\e[1~'|$'\e0H'|$'\e[H')  # home key:
#         #     cur=0
#         #     home.key
#         #     echo home;;

#         # $'\e[4~'|$'\e0F'|$'\e[F')  # end key:
#         #     ((cur=$#-1))
            
#         #     echo end;;

#         "")   # Space or Enter Key
#             space.enter.key
#             echo space;;

#         q) # q: quit
#             quit.key
#             echo Bye!
#             exit;;

#     esac    

#     done
                 
# }

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
            echo up;;

        $'\e[D'|$'\e0D') # left arrow
            ((cur > 1)) && ((cur--))
            echo left;;

        $'\e[B'|$'\e0B')  # down arrow
            ((cur < $#-1)) && ((cur++))
            echo down;;

        $'\e[C'|$'\e0C')  # right arrow
            ((cur < $#-1)) && ((cur++))
            echo right;;

        # $'\e[1~'|$'\e0H'|$'\e[H')  # home key:
        #     cur=0
        #     home.key
        #     echo home;;

        # $'\e[4~'|$'\e0F'|$'\e[F')  # end key:
        #     ((cur=$#-1))
            
        #     echo end;;

        $"")   # Space or Enter Key
            echo space;;

        q) # q: quit
            # quit.key
            echo quit
            # exit;;

    esac    

}

# keyboard_handler usage
# while true; do
#     key=$(keyboard_handler)
#     echo "This was pressed:  $key"
#     if [[  $key == "Bye!" ]]; then
#         break;
#     fi
# done