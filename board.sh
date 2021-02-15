#!/bin/bash
# # Universal Position on LUDO Board based on indexes
# # We make the \

declare -A board_tiles

link.tiles(){
    local tile1=$1
    local tile2=$2
    board_tiles[$tile1:next]=$tile2
    board_tiles[$tile2:back]=$tile1
}

chain.horz(){
    # $1 is the row number
    # $2 is the starting col number
    # $3 is the ending col number
    # $4 is the direction -4 means left and +4 means right
    # $5 is the extra data color we want to have associated with tile
    
    for ((col=$2;col!=$3;col+=$4)); do
        # board_tiles[$1;$col:0]="$1;$((col+$4))"
        link.tiles "$1;$col" "$1;$((col+$4))"
    done
}

chain.vert(){
    # $1 is the starting row number
    # $2 is the ending row number
    # $3 is the col number
    # $4 is the direction -2 means up and +2 means down
    # $5 is the extra data color we want to have associated with tile

    for ((row=$1; row!=$2; row+=$4)); do
        # board_tiles[$row;$3:0]="$((row+$4));$3"
        link.tiles "$row;$3" "$((row+$4));$3"
    done
}

##########################START###############################
# Creating the main path for Ludo Game

## 1 based Horizontal Index


chain.vert 12 2 27 -2
chain.horz 2 27 35 4
chain.vert 2 12 35 2
link.tiles "12;35" "14;39"

chain.horz 14 39 59 4
chain.vert 14 18 59 2
chain.horz 18 59 39 -4
link.tiles "18;39" "20;35"

chain.vert 20 30 35 2
chain.horz 30 35 27 -4
chain.vert 30 20 27 -2
link.tiles "20;27" "18;23"


chain.horz 18 23 3 -4
chain.vert 18 14 3 -2
chain.horz 14 3 23 4
link.tiles "14;23" "12;27"


###########################END################################


##########################START###############################
# Creating the tunnels for the players

board_tiles[16;3:tunnel]="16;7"
board_tiles[16;7:back]="16;3"
board_tiles[16;23:next]="7;13"
chain.horz 16 7 23 4

board_tiles[16;59:tunnel]="16;55"
board_tiles[16;55:back]="16;59"
board_tiles[16;39:next]="25;49"
chain.horz 16 55 39 -4

board_tiles[2;31:tunnel]="4;31"
board_tiles[4;31:back]="2;31"
board_tiles[12;31:next]="7;49"
chain.vert 4 12 31 2

board_tiles[30;31:tunnel]="28;31"
board_tiles[28;31:back]="30;31"
board_tiles[20;31:next]="25;13"
chain.vert 28 20 31 -2
###########################END################################

##########################START############################### 
# Creating the Safe Points
safepoints=("14;5" "18;7" "6;15" "4;19" "14;27" "18;29" "26;19" "28;15")

for i in ${safepoints[@]}; do
    board_tiles[$i:safety]="safe"
done
      

###########################END################################

source pawns.sh

##########################START###############################
# Try printing stuff

source printing.sh

paint.board(){

    # clear
    # bring the cursor to 1 1 coordinates
    tput cup 0 0
    cat "design_board.txt"

    local total_colors=("y" "b" "r" "g")

    local colored_boxes=(
        "14;7"  "18;11"  # Yellow Boxes
        "6;27"  "4;35"   # Blue Boxes
        "14;51" "18;55"  # Red Boxes
        "28;27" "26;35"  # Green Boxes 
    )

    local i=0

    for index in "${!colored_boxes[@]}"; do
        color_tile=${total_colors[$(($index/2))]}
        coords=${colored_boxes[$index]}

        # print.box.auto $coords "$color_tile"
        print.box $coords "$color_tile"
    done

    #Yellow Boxes
    for i in {7..23..4}; do
        print.box "16;$i" y
    done

    #Blue Boxes
    for j in {4..12..2}; do
        print.box "$j;31" b
    done

    #Red Boxes
    for j in {39..55..4}; do
        print.box "16;$j" r
    done

    #Green Boxes
    for j in {20..28..2}; do
        print.box "$j;31" g
    done

    print.ludo
}


print.ludo

paint.board

tput civis -- invisible
stty -echo
# open.pawn r 1 
init.pawn


print.all.pawns 
open.pawn b 0
open.pawn b 1
open.pawn b 2
open.pawn b 3
open.pawn r 0
open.pawn r 1
open.pawn r 2
open.pawn r 3
print.all.pawns 

# get.movable.pawns r 6




source utils.sh
source pawns.sh
########################################################


# player.turn(){
#     local color=$1
#     local curr_selected_pawn=1

#     ludo.dice.roll $color

#     while [[ -n $dice_values ]]; do
#         # While we have some moves left because of dice

#         # Get the amount we want to move 
#         move_amount=${dice_values:0:1}

#         # Remove the move_amount from the dice_values string, so we don't repeat it
#         dice_values=${dice_values:1}

#         # get.movable.pawns $color $move_amount
#         # curr_selected_pawn=$movable_pawns_arr

#         while true; do
#             key=$(keyboard_handler)
#             case "$key" in
#                 ":left")
                    
#                     break
#                 ;;

#                 ":right")

#                     break
#                 ;;

#                 ":space")
#                     move.pawn $color $curr_selected_pawn $move_amount next
#                     break
#                     ;;
#             esac
#         done 

#         curr_selected_pawn=$(($curr_selected_pawn % ${#movable_pawns_arr}))

#     done

#     # local exit_cond=""
#     # while [[ -z $exit_cond ]]; do
#     #     key=$(keyboard_handler)

#     #     case "$key" in

#     #         ":left")

#     #         ;;
#     #         ":right")


#     #         ;;
            
#     #     esac
#     # done

# }

player.turn(){
    color=$1


    ludo.dice.roll $color
    # get.movable.pawns $color $dice_val
    index=0
    highlight.pawn $color $index
    
    local exit=""
    while [[ -z $exit ]]; do
        key=$(keyboard_handler)

        case "$key" in

        ":left")
            unhighlight.pawn $color $index
            index=$(increment.limit $index 4 1)
            highlight.pawn $color $index
        ;;

        ":right")
            unhighlight.pawn $color $index
            index=$(increment.limit $index 4 -1)
            highlight.pawn $color $index
        ;;

        ":space")
            move.pawn $color $index $dice_val next
            print.all.pawns
            break
        ;;
        esac
    done
}

########################################################################
 

all_p_colors=(y b g r)
move.pawn r 0 49
move.pawn r 1 49
move.pawn r 2 49
move.pawn r 3 49
ii=0
while true; do
#$((RANDOM % 4))]}
    ii=3
    player.turn ${all_p_colors[$ii]} 
    ii=$(increment.limit $ii 4 1)

    if [[ $exit_condi == "exit" ]]; then
        break
    fi
done
echo ${finished_players[@]}
stty echo
tput cnorm   -- normal
###########################END################################