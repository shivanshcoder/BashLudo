
##########################START###############################

# Box colors Definitions

redfg="\e[31m"
redbg="\e[41m"
redbg=""

bluefg="\e[34m"
bluebg="\e[44m"
bluebg=""

greenfg="\e[32m"
greenbg="\e[42m"
greenbg=""

yellowfg="\e[33m"
yellowbg="\e[43m"
yellowbg=""

declare -A colors
# Green
colors[green:bg]=42
colors[green:border]=32
colors[green:text]=32
colors[green:text_bg]=32

# Red
colors[red:bg]=41
colors[red:border]=31
colors[red:text]=31
colors[red:text_bg]=31

# Blue
colors[blue:bg]=44
colors[blue:border]=34
colors[blue:text]=34
colors[blue:text_bg]=34

# Yellow
colors[yellow:bg]=43
colors[yellow:border]=33
colors[yellow:text]=33
colors[yellow:text_bg]=33


###########################END################################

text=41
textbg=33

# printf "\e[${text};${textbg};7;5m $ "

print.box(){
    color=$2
    bgcolor=$3

    printf "\e[$1H\e[1A\e[2D" 
    printf "$color"
    printf "+---+"
    printf "\e[1B\e[5D"
    printf "|${bgcolor} $ \e[0m${color}|"
    printf "\e[1B\e[5D"
    printf "+---+\e[0m"
}

# print.box "5;5" $redfg $redbg


##########################START###############################

# Pawn colors Definitions

# redfg="\e[31m"
# redbg="\e[41m"

# bluefg="\e[34m"
# bluebg="\e[44m"

# greenfg="\e[32m"
# greenbg="\e[42m"

# yellowfg="\e[33m"
# yellowbg="\e[43m"

# declare -A pawn_colors
# # Green
# pawn_colors[green:bg]=42
# pawn_colors[green:border]=32
# pawn_colors[green:text]=32

# # Red
# pawn_colors[red:bg]=41
# pawn_colors[red:border]=31
# pawn_colors[red:text]=31

# # Blue
# pawn_colors[blue:bg]=44
# pawn_colors[blue:border]=34
# pawn_colors[blue:text]=34

# # Yellow
# pawn_colors[yellow:bg]=43
# pawn_colors[yellow:border]=33
# pawn_colors[yellow:text]=33


###########################END################################

Color_Off="\e[0m "       # Text Reset

# Regular Colors
Black="\e[0;30m "        # Black
Red="\e[0;31m "          # Red
Green="\e[0;32m "        # Green
Yellow="\e[0;33m "       # Yellow
Blue="\e[0;34m "         # Blue
Purple="\e[0;35m "       # Purple
Cyan="\e[0;36m "         # Cyan
White="\e[0;37m "        # White

# Bold
BBlack="\e[1;30m "       # Black
BRed="\e[1;31m "         # Red
BGreen="\e[1;32m "       # Green
BYellow="\e[1;33m "      # Yellow
BBlue="\e[1;34m "        # Blue
BPurple="\e[1;35m "      # Purple
BCyan="\e[1;36m "        # Cyan
BWhite="\e[1;37m "       # White

# Underline
UBlack="\e[4;30m "       # Black
URed="\e[4;31m "         # Red
UGreen="\e[4;32m "       # Green
UYellow="\e[4;33m "      # Yellow
UBlue="\e[4;34m "        # Blue
UPurple="\e[4;35m "      # Purple
UCyan="\e[4;36m "        # Cyan
UWhite="\e[4;37m "       # White

# Background
On_Black="\e[40m "       # Black
On_Red="\e[41m "         # Red
On_Green="\e[42m "       # Green
On_Yellow="\e[43m "      # Yellow
On_Blue="\e[44m "        # Blue
On_Purple="\e[45m "      # Purple
On_Cyan="\e[46m "        # Cyan
On_White="\e[47m "       # White

# High Intensty
IBlack="\e[0;90m "       # Black
IRed="\e[0;91m "         # Red
IGreen="\e[0;92m "       # Green
IYellow="\e[0;93m "      # Yellow
IBlue="\e[0;94m "        # Blue
IPurple="\e[0;95m "      # Purple
ICyan="\e[0;96m "        # Cyan
IWhite="\e[0;97m "       # White

# Bold High Intensty
BIBlack="\e[1;90m "      # Black
BIRed="\e[1;91m "        # Red
BIGreen="\e[1;92m "      # Green
BIYellow="\e[1;93m "     # Yellow
BIBlue="\e[1;94m "       # Blue
BIPurple="\e[1;95m "     # Purple
BICyan="\e[1;96m "       # Cyan
BIWhite="\e[1;97m "      # White

# High Intensty backgrounds
On_IBlack="\e[0;100m "   # Black
On_IRed="\e[0;101m "     # Red
On_IGreen="\e[0;102m "   # Green
On_IYellow="\e[0;103m "  # Yellow
On_IBlue="\e[0;104m "    # Blue
On_IPurple="\e[10;95m "  # Purple
On_ICyan="\e[0;106m "    # Cyan
On_IWhite="\e[0;107m "   # White