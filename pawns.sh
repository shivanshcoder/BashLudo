
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

    local finish_tile=$3


    # shift so that only home_tile coordinates are left in the array
    shift 
    shift
    shift
    
    # Set home tiles, where the pawns are placed from start
    local h_tiles=($@)

    for i in {0..3}; do
        #Used to determine which pawns have finished the game
        pawns[$color:pawns_left]=4

        pawns[$color:$i:start_tile]=$start_tile
        pawns[$color:$i:pawn_char]=$pawn_char
        pawns[$color:$i:finish]=$finish_tile

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

    init.pawn.prop y "14;7" "7;13" ${home_tiles_y[@]}
    init.pawn.prop b "4;35" "7;49" ${home_tiles_b[@]}
    init.pawn.prop g "28;27" "25;13"  ${home_tiles_g[@]}
    init.pawn.prop r "18;55" "25;49"  ${home_tiles_r[@]}
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

    if [[ ${pawns[$color:$pawn_num:steps_taken]} -gt $((56 - $num_steps)) ]]; then 
        # Invalid move, can't take extra steps
        return 1
    fi



    if [[ $num_steps -eq 6 || $num_steps -eq 1 ]]; then
        if [[ ${pawns[$color:$pawn_num:cur_pos]} == ${pawns[$color:$pawn_num:home_tile]} ]]; then
            # open the pawn if we get  6 or 1
            open.pawn $color $pawn_num
            return 1
        fi
    fi

    if [[ ${pawns[$color:$pawn_num:cur_pos]} == ${pawns[$color:$pawn_num:home_tile]} ]]; then
        # pawn is closed can't move
        return 1
    fi

    move_type=$4


    for (( steps=1; steps<=$num_steps;steps++ )); do
        local tile_pos=${pawns[${color}:${pawn_num}:cur_pos]}

        pawns[$color:$pawn_num:steps_taken]=$((${pawns[$color:$pawn_num:steps_taken]}+1)) 

        # sleep .1

        if [[ ${pawns[$color:$pawn_num:steps_taken]} -eq 51 ]]; then 
            change.pawn.pos $color $pawn_num ${board_tiles[$tile_pos:tunnel]}
        else
            change.pawn.pos $color $pawn_num ${board_tiles[$tile_pos:next]}
        fi        
        
    done


    if [[ ${pawns[$color:$pawn_num:cur_pos]} == ${pawns[$color:$pawn_num:finish]} ]]; then
        # The Pawn is in finished state
        pawns[$color:pawns_left]=$((${pawns[$color:pawns_left]} - 1))

        if [[ ${pawns[$color:pawns_left]} -eq 0 ]]; then
            # The color is finished playing
            finished_players+=(r)

            exit_condi="exit"
        fi
        return 1;
    fi
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
#         # If the current Position is 
#         if [[ ${pawns[$color:$i:cur_pos]} == ${pawns[$color:$i:home_tile]} && $move_amount -eq 6 && $move_amount -eq 1 ]]; then
#             movable_pawns_arr+=($i)
#             continue
#         fi

#         if [[ ${pawns[$color:$i:steps_taken]} -eq $($pawn_max_steps - $move_amount) ]]; then

#         fi



        
#         # 
#     done

#     movable_pawns_arr=1
    
# }


get.movable.pawns(){
    local color=$1
    local move_amount=$2
    movable_pawns_arr=(

    )
    for i in {0..3}; do
        # Check if the pawn is open
        # If the current Position is 

        if [[ ${pawns[$color:$i:cur_pos]} == ${pawns[$color:$i:home_tile]}  ]]; then
            if [[ $move_amount -ne 6 && $move_amount -ne 1 ]]; then
                continue
            fi
        fi
        movable_pawns_arr+=($i)
    done    
}

###########################END################################
