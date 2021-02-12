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
chain.horz 16 7 23 2

board_tiles[16;59:tunnel]="16;55"
board_tiles[16;55:back]="16;59"
chain.horz 16 55 39 -2

board_tiles[2;31:tunnel]="4;31"
board_tiles[4;31:back]="2;31"
chain.vert 4 12 31 2

board_tiles[30;31:tunnel]="28;31"
board_tiles[28;31:back]="30;31"
chain.vert 28 20 31 -2
###########################END################################

##########################START############################### 
# Creating the Safe Points
safepoints=("14;5" "18;7" "6;15" "4;19" "14;27" "18;29" "26;19" "28;15")

for i in ${safepoints[@]}; do
    board_tiles[$i:safety]="safe"
done
      

###########################END################################


##########################START###############################
# Start with the player colors and pawns

declare -A pawns

pawn_open_steps=50 #Unsafe steps, open game steps
pawn_max_steps=56 #Steps after game finishes for the pawn


init.pawn.prop(){
    # Get the color
    local color=$1
    
    local pawn_char=${color^}

    # Set the start tile, where the pawns enter the game for moving
    local start_tile=$2


    # shift so that only home_tile coordinates are left in the array
    shift 
    shift
    
    # Set home tiles, where the pawns are placed from start
    local h_tiles=($@)

    for i in {1..4}; do
        pawns[$color:$i:start_tile]=$start_tile
        pawns[$color:$i:pawn_char]=$pawn_char

        pawns[$color:$i:home_tile]=${h_tiles[$((i-1))]}
        pawns[$color:$i:cur_pos]=${h_tiles[$((i-1))]}
        pawns[$color:$i:steps_taken]=0
    done

}

init.pawn(){

    local home_tiles_y=("4;7" "10;7" "4;19" "10;19")  # Yellow Boxes
    local home_tiles_b=("4;43" "10;43" "4;55" "10;55") # Blue Boxes
    local home_tiles_r=("22;43" "28;43" "22;55" "28;55") # Red Boxes
    local home_tiles_g=("22;7" "28;7" "22;19" "28;19") # Green Boxes 

    init.pawn.prop y "14;7" ${home_tiles_y[@]}
    init.pawn.prop b "4;35" ${home_tiles_b[@]}
    init.pawn.prop g "28;27"  ${home_tiles_g[@]}
    init.pawn.prop r "18;55"  ${home_tiles_r[@]}


    
}




###########################END################################


##########################START###############################
# Try printing stuff

declare -A colors
colors[r]=31
colors[b]=34
colors[g]=32
colors[y]=33


print.box(){
    local color="\e[${colors[$2]}m"


    printf "\e[$1H\e[1A\e[2D" 
    printf "${color}"
    printf "+---+"
    printf "\e[1B\e[5D"
    printf "|   |"
    printf "\e[1B\e[5D"
    printf "+---+\e[0m"
}


print.pawn(){
    # $1 is the color of the pawn
    # $2 is the number of the pawn
    local pos=${pawns[$1:$2:cur_pos]}
    local color_code=${colors[$1]}
    local pawn_char=${pawns[$1:$2:pawn_char]}
    printf "\e[${pos}H\e[1D\e[1;${color_code};5m $pawn_char \e[0m"
}
print.pawn.empty(){
   printf "\e[${1}H\e[1D\e[0m   "

}


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

    printf "\e[3;5H$Ludo_L"
    printf "\e[3;41H$Ludo_U"
    printf "\e[21;5H$Ludo_D"
    printf "\e[21;41H$Ludo_O"
}

printf "\e[5m\e[3;5H$Ludo_L"
printf "\e[5m\e[3;41H$Ludo_U"
printf "\e[5m\e[21;5H$Ludo_D"
printf "\e[5m\e[21;41H$Ludo_O"
# read d




paint.board
# read

change.pawn.pos(){
    # Changes the position of a pawn
    # Erases the pawn from old position and prints it to the new position
    # Also updates the current position of the pawn
    local color=$1
    local pawn_num=$2
    local new_pos=$3

    print.pawn.empty ${pawns[$color:${pawn_num}:cur_pos]}

    pawns[$color:${pawn_num}:cur_pos]=$new_pos
    sleep .4
    # print.pawn ${pawns[$color:${pawn_num}:cur_pos]} ${colors[$color]}
    print.pawn $color $pawn_num
}

open.pawn(){
    local color=$1
    local pawn_num=$2
    
    # pawns[$color:${pawn_num}:cur_pos]=${pawns[${color}:${pawn_num}:start_tile]}
    change.pawn.pos $color $pawn_num ${pawns[${color}:${pawn_num}:start_tile]}
}

move.pawn(){
    local color=$1
    local pawn_num=$2

    local num_steps=$3


    for (( steps=1; steps<=$num_steps;steps++ )); do
        local tile_pos=${pawns[${color}:${pawn_num}:cur_pos]}
        sleep .5
        
        change.pawn.pos $color $pawn_num ${board_tiles[$tile_pos:$4]}
        
    done

    pawns[$color:$pawn_num:steps_taken]=$((${pawns[$color:$pawn_num:steps_taken]}+$num_steps)) 
}


tput civis      -- invisible
stty -echo
# open.pawn r 1 
init.pawn
my.pwn(){
    # print.pawn ${pawns[$1:$2:cur_pos]} ${colors[$1]}
    print.pawn $1 $2
}
my.pwn r 1
my.pwn r 2
my.pwn r 3
my.pwn r 4
# sleep 4
# change.pawn.pos r 1 "18;55"
open.pawn r $1
# move.pawn r 1 3 next
# my.pwn r $1


source utils.sh
########################################################

player.dice.roll(){
    dice.roll 31

    if [[ dice_val -eq 6 ]]; then
        dice.roll 31
    fi

    if [[ dice_val -eq 6 ]]; then
        dice.roll 31
    fi
    printf "$dice_values"
}

# player.turn(){
#     $color=$1
#     $curr_selected_pawn=1

#     dice.roll ${colors[$color]}
#     local exit_cond=""
#     while [[ -z $exit_cond]]

# }

########################################################################
 

exit=""
while [[ -z $exit ]]; do
        key=$(keyboard_handler)

        case "$key" in 


            q)
                exit="EXIT"
                break;;
            ":space")
                player.dice.roll ${colors[r]}
                move.pawn r "1" $(pop.dice.value) next
                echo $dice_values
                ;;

            ":up")
                move.pawn r 1 "1" next
                ;;

            ":down")
                move.pawn r 1 "1" back
                ;;        
                

        esac
done
# read
stty echo
tput cnorm   -- normal
###########################END################################