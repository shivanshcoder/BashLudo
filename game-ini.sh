
#!/bin/bash

game.start(){

    while true; do

        printf "\nWelcome to Ludo Game"
        printf "\nHow many players are going to play (2-4)\n"
        read num_players

        if  [[ $num_players -gt 4 ]] || [[ $num_players -lt 2 ]]; then
            printf "Players can be between 2 to 4 only"
        else 
            break
        fi

    done

}

game(){
    printf "GAME"
}

my.select(){

    select os in yes no
    do

    case $os in
    # Two case values are declared here for matching
    "Ubuntu"|"LinuxMint")
    echo "I also use $os."
    ;;
    # Three case values are declared here for matching
    "Windows8" | "Windows10" | "WindowsXP")
    echo "Why don't you try Linux?"
    ;;
    # Matching with invalid data
    *)
    echo "Invalid entry."
    break
    ;;
    esac
done
}

game.loop(){
    clear

    game.start

    game

    clear

    printf "Play Again?"
    read answer


    

}


# game.loop

myfun(){
    echo "HELLO"
    echo 4545
}

myvar=$(myfun)
echo $myvar