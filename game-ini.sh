
#!/bin/bash

#Global Game Variables

# Game keeps running till this variable has value no
exit.game=no



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
    "yes"|"no")
    echo "$os"
    ;;

    *)
    echo "Invalid."
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

    printf "Exit Game?"
    read answer


}


# game.loop

myfun(){
    echo "HELLO"
    echo 4545
}

myvar=$(myfun)
echo $myvar