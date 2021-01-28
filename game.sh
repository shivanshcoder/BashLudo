#!/bin/bash


# source game-ini.sh

# game.loop


myloop(){

    if [ -z $1 ]; then
        echo "No Args"
    else
        echo "Args given"
    fi
}

myloop