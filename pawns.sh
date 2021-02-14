
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
        pawns[$color:$i:can_move]=false
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


choose.pawn(){
    color=$1
    
    curr_selected_pawn=1

}



# Implement it later
# get.movable.pawns(){
#     local color=$1
#     local move_amount=$2

#     for i in {1..4}; do
#         # Check if the pawn is open
#         echo s
#         # 
#     done

#     movable_pawns_arr=1
    
# }


###########################END################################
