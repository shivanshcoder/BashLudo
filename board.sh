#!/bin/bash
# # Universal Position on LUDO Board based on indexes
# # We make the \

declare -A board_tiles

chain.horz(){
    # $1 is the row number
    # $2 is the starting col number
    # $3 is the ending col number
    # $4 is the direction -2 means left and +2 means right
    # $5 is the extra data color we want to have associated with tile
    
    for ((col=$2;col!=$3;col+=$4)); do
        board_tiles[$1;$col:0]="$1;$((col+$4))"
    done
}

chain.vert(){
    # $1 is the row number
    # $2 is the starting col number
    # $3 is the ending col number
    # $4 is the direction -2 means up and +2 means down
    # $5 is the extra data color we want to have associated with tile

    for ((row=$1; row!=$2; row+=$4)); do
        board_tiles[$row;$3:0]="$((row+$4));$3"
    done
}

##########################START###############################
# Creating the main path for Ludo Game

## 1 based Horizontal Index

chain.vert 12 2 15 -2
chain.horz 2 15 19 2
chain.vert 2 12 19 2
board_tiles[12;19:0]="14;21"

chain.horz 14 21 31 2
chain.vert 14 18 31 2
chain.horz 18 31 21 -2
board_tiles[18;21:0]="20;19"

chain.vert 20 30 19 2
chain.horz 30 19 15 -2
chain.vert 30 20 15 -2
board_tiles[20;15:0]="18;13"

chain.horz 18 13 3 -2
chain.vert 18 14 3 -2
chain.horz 14 3 13 2
board_tiles[14;13:0]="12;15"


###########################END################################


##########################START###############################
# Creating the tunnels for the players

board_tiles[16;3:1]="16;5"
chain.horz 16 5 13 2

board_tiles[16;31:1]="16;29"
chain.horz 16 29 21 -2

board_tiles[2;17:1]="4;17"
chain.vert 4 12 17 2

board_tiles[30;17:1]="28;17"
chain.vert 28 20 17 -2
###########################END################################

##########################START###############################

# Setting Extra information regarding the tiles

set.paint.linked(){
    # Sets paint attributes for array of tiles and further if chain(linked) exists

    # The Color which we want to set for the 
    color=$1
    shift

    # Get all the 
    tiles=($@)

    for tile in $tiles; do
        ptr=$tile
        while true; do
            if [ -n "${board_tiles[$ptr:color]}" ]; then
                # echo "EXIT REPEAT"
                break
            fi
            
            board_tiles[${ptr}:color]=$color;

            ptr=${board_tiles[$ptr:0]};

            if [ -z ${board_tiles[$ptr:0]} ]; then
                break
            fi
        done
    done

}

set.tile.attr(){

    ptr=$1 # Get the first tile
    shift
    chain_limit=$1 # Get the upper limit for stopping checking the linked tiles, because there could be closed cycle of tiles
    shift
    echo $chain_limit

    for tile_number in {1..$chain_limit}; do
        echo $1
        property_name=$1 # Get the property name
        shift
        property_value=$1 # Get the property value for soring
        shift

        if [ -z "$property_name" ]; then
            break
        fi

        board_tiles[${ptr}:$property_name]=$property_value
        ptr=${board_tiles[$ptr:0]};
    done
        
}

# for tile_index in {1..52..1}; do
#     board_tiles[${ptr}:color]="plain"
#     ptr=${board_tiles[$ptr:0]}
#     echo $ptr

# done
# echo ${#board_tiles[@]}
# echo ${board_tiles[@]}
# read s

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


init.pawn.prop(){
    # Get the color
    color=$1
    
    # Set the start tile, where the pawns enter the game for moving
    start_tile=$2

    # shift so that only home_tile coordinates are left in the array
    shift 
    shift
    
    # Set home tiles, where the pawns are placed from start
    home_tiles=$@


    for i in {1..4}; do
        pawns[$color:$i:start_tile]=$start_tile
        pawns[$color:$i:home_tile]=${home_tiles[$((i+1))]}
    done

}

init.pawn(){

    local home_tiles_y=("4;7" "10;7" "4;19" "10;19")  # Yellow Boxes
    local home_tiles_b=("4;43" "10;43" "4;55" "10;55") # Blue Boxes
    local home_tiles_g=("22;43" "28;43" "22;55" "28;55") # Red Boxes
    local home_tiles_r=("22;7" "28;7" "22;19" "28;19") # Green Boxes 

    init.pawn.prop y "18;29" ${home_tiles_y[@]}
    init.pawn.prop b "28;15" ${home_tiles_b[@]}
    init.pawn.prop g "14;5"  ${home_tiles_g[@]}
    init.pawn.prop r "4;19"  ${home_tiles_r[@]}

}




###########################END################################


##########################START###############################
# Try printing stuff

source colors.sh


print.func(){
    printf $1
}

# print.box(){
#     color=$2
#     # bgcolor=$3

#     printf "\e[$1H\e[1A\e[2D" 
#     printf "$color"
#     printf "+---+"
#     printf "\e[1B\e[5D"
#     printf "|${bgcolor}   \e[0;m${color}|"
#     printf "\e[1B\e[5D"
#     printf "+---+\e[0m"
# }

print.box.auto(){

    color=$2
    border_color=${colors[$color:border]}
    # bgcolor=${colors[$color:bg]}
    # bgcolor=""
    
    printf "\e[m\e[$1H\e[1A\e[2D" 
    printf "\e[${border_color}m"
    printf "+---+"
    printf "\e[1B\e[5D"
    # printf "|\e[${bgcolor}m   \e[0m\e[${border_color}m|"
    printf "|   |"
    printf "\e[1B\e[5D"
    printf "+---+\e[0m"
}


print.box.sample(){
    addr=$1


}

print.box.auto "14;17" "red"
read s
print.pawn(){
    text_color=$2
    printf "\e[${1}H\e[1D\e[1;${text_color};40;7;5m 1 \e[0m"
}
clear

source printing.sh

paint.board(){

    # clear
    # bring the cursor to 1 1 coordinates
    tput cup 0 0
    cat "design_board.txt"

    total_colors=("yellow" "blue" "red" "green")

    colored_boxes=(
        "14;7"  "18;11"  # Yellow Boxes
        "6;27"  "4;35"   # Blue Boxes
        "14;51" "18;55"  # Red Boxes
        "28;27" "26;35"  # Green Boxes 
    )

    i=0

    for index in "${!colored_boxes[@]}"; do
        color_tile=${total_colors[$(($index/2))]}
        coords=${colored_boxes[$index]}

        print.box.auto $coords "$color_tile"
    done

    #Yellow Boxes
    for i in {7..23..4}; do
        print.box "16;$i" $yellowfg $yellowbg
    done

    #Blue Boxes
    for j in {4..12..2}; do
        print.box "$j;31" $bluefg $bluebg
    done

    #Red Boxes
    for j in {39..55..4}; do
        print.box "16;$j" $redfg $redbg
    done

    #Green Boxes
    for j in {20..28..2}; do
        print.box "$j;31" $greenfg $greenbg
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
read d


paint.board
read
###########################END################################