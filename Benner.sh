#!/bin/bash
r="\033[1;31m"
g="\033[1;32m"
c="\033[1;36m"
b="\033[1;34m"
n="\033[0m"
boxq="\033[1;34m[\033[1;32m?\033[1;34m]"
boxg="\033[1;34m[\033[1;32m+\033[1;34m]"
boxr="\033[1;34m[\033[1;31m!\033[1;34m]"
. <(curl -sLo- "https://raw.githubusercontent.com/RUR999/spinner/refs/heads/main/spin.sh")

banner() {
    echo -en "\n${b}╔═══╗╔═══╗╔═══╗╔═╦╦═╦╗\n║╔═╗║║╔═╗║║╔═╗║║═╬╣═╣╚╗\n║╚═╝║║╚═╝║║╚═╝║║╔╣╠═║║║\n╚══╗║╚══╗║╚══╗║╚╝╚╩═╩╩╝\n╔══╝║╔══╝║╔══╝║ ${g}By RUR 999\n${b}╚═══╝╚═══╝╚═══╝ \n\n${n}"
}

setfile(){
    if [ -f $HOME/../usr/etc/motd ]; then
    rm -rf $HOME/../usr/etc/motd
    fi
    if [ -f $HOME/.config/fish/functions/fish_prompt.fish ]; then
    rm -rf $HOME/.config/fish/functions/fish_prompt.fish
    touch $HOME/.config/fish/functions/fish_prompt.fish
    else
    touch $HOME/.config/fish/functions/fish_prompt.fish
    fi
}

termpro(){
    echo -en "${boxq} ${g}Do You Want To Change Extra Key & Cursor Style? (y/n)${n} "
    read tp
    case $tp in
    Y|y)
    if [ -f $HOME/.termux/termux.properties ]; then
    rm -rf $HOME/.termux/termux.properties
    fi
    (curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/files/termux.properties -o $HOME/.termux/termux.properties) &> /dev/null & spin
    ;;
    N|n) 
    echo ""
    ;;
    *) echo -e "${boxr} ${r}Wrong Input"
    termpro
    ;;
    esac
}



setban(){
    clear;banner
    echo -en "${boxq} ${g}Enter Bar Name${n}: "
    read name
    echo "set name \"${name}\""> $HOME/.config/fish/functions/fish_prompt.fish
    cat $HOME/.config/fish/functions/temp.fish >> $HOME/.config/fish/functions/fish_prompt.fish
}

main(){
    clear; banner
    setfile
    setban
    termpro
    chsh -s fish
    termux-reload-settings
    clear; banner
    echo -e "${boxg} ${g}Now Exit From Termux And Again Open Termux${n}"
}

clear;banner
pkgs=( fish figlet )
for pkg in "${pkgs[@]}";do
    echo -e "${boxg} ${g}Installing ${pkg}${n}"
    (pkg install -y ${pkg}) &> /dev/null & spin
    if [[ $(command -v ${pkg}) ]]; then
    echo -e "${boxg}${g} ${pkg} Installed Successfull${n}"
    else
    echo -e "${boxr} ${r}${pkg} Install Error ${g}First ${pkg} Install Manually Then Run Again${n}"
    exit
    fi
done
echo -e "${boxg} ${g}Downloading Functions File${n}"
(curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/functions/fish_greeting.fish -o $HOME/.config/fish/functions/fish_greeting.fish) &> /dev/null & spin
(curl https://raw.githubusercontent.com/RUR999/999.fish/refs/heads/main/functions/fish_prompt.fish -o $HOME/.config/fish/functions/temp.fish) &> /dev/null & spin
(curl https://raw.githubusercontent.com/DH-Alamin/Termux_Banner/refs/heads/main/config.fish -o $HOME/.config/fish/config.fish) &> /dev/null & spin
(curl https://raw.githubusercontent.com/xero/figlet-fonts/refs/heads/master/ANSI%20Regular.flf -o $HOME/../usr/share/figlet/ar.flf) &> /dev/null & spin
main
rm -rf $HOME/.config/fish/functions/temp.fish
