## my custom functions and aliases for ~/.bashrc
## LeKilleRGallet 
##

#python related aliases
alias py='python3'
alias python='python3'
alias avenv='source venv/bin/activate'
alias ignorevenv="echo 'venv/' >> .gitignore"
alias requirements="pip freeze > requirements.txt"

#git related aliases
alias undocommit='git reset --soft HEAD~1'
alias github='xdg-open https://github.com/$(git config user.name)' #open you profile in github if ur git user.name == github username

#bashrc related aliases
alias bashrc="source ~/.bashrc"
alias code.bashrc="code ~/.bashrc"

##
alias upgrade='sudo apt update && sudo apt upgrade'

#       FUNCTIONS
function pygenesis() {
    if [ -z "$1" ]; then
        #if no argument is passed create a venv with default python version
        python -m venv venv
    else
        
        if [[ $1 =~ ^[0-9]+\.[0-9]+$ ]]; then
            #if argument $1 is a version number create a venv with that version
            python$1 -m venv venv
        else
            #if argument $1 is not a version number create a default venv
            python -m venv venv
        fi
    fi
    ignorevenv
    avenv
    for i in $@; do
        if [[ $i == "-"* ]]; then
            #if a argument have a hyphen at the beginning is asumed to be a pip install command
            lib=$(echo $i | sed 's/-//')
            pip install $lib
        fi
    done
    requirements
    deactivate
}

function gitcommitdate() {
    git add .
    git commit -m "Updated: `date +'%d/%m/%Y'`"
}

function gitgenesis() {
    git init
    git add .
    git commit -m"genesis"
}

function sketch() {
    if [[ "$1" == "python" || "$1" == "py" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.py
    elif [[ "$1" == "c" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.c
    elif [[ "$1" == "cpp" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.cpp
    elif [[ "$1" == "java" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.java
    elif [[ "$1" == "r" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.r
    elif [[ "$1" == "sol" ]]; then
        code /home/$USER/learning/sketchbook/Sketch.sol
    elif [[ "$1" == "all" ]]; then
        (cd /home/$USER/learning/sketchbook/; code .)
    else
        echo -e "sketch [py|c|cpp|java|r|sol]"
    fi
}

function commitpush() {
    #
    if [[ "$1" == "sketch" ]]; then
        (cd ~/learning/sketchbook/; gitcommitdate)
        (cd ~/learning/sketchbook/; git push origin master)
    elif [[ "$1" == "platzi" ]]; then
        (cd ~/learning/platzi/; gitcommitdate)
        (cd ~/learning/platzi/; git push origin master)
    elif [[ "$1" == "university" ]]; then
        (cd ~/learning/university/; gitcommitdate)
        (cd ~/learning/university/; git push origin master)
    elif [[ "$1" == "linuxshell" ]]; then
        (cd /home/$USER ;sed -n '119,$p' ~/.bashrc > /home/$USER/learning/linuxshell/.bashrc) #validate both files are different before overwriting
        (cd ~/learning/linuxshell/; gitcommitdate)
        (cd ~/learning/linuxshell/; git push origin master --force) ##
    #validate need commit for proyects and all
    else
        echo -e "commitpush [sketch|platzi|university|linuxshell] \n soon: proyects & all"
    fi
}

function wifianx() { #just for realtek 8821CU drivers, note: idk but when i upgrade kernel i need to reinstall wifi drivers
    if [ -d /home/$USER/build/rtl8821CU ]; then
        cd ~/build/rtl8821CU/
        sudo make uninstall
        cd ..
        rm -rf rtl8821CU/
    else
        cd ~/build/
    fi
    git clone https://github.com/brektrou/rtl8821CU.git
    cd ~/build/rtl8821CU
    make
    sudo make install
    echo -e '//'
    echo -e 'Diver has been installed'
    echo -e 'The Computer should be rebooted to apply changes'
    echo -e '//'
    sleep 1m
    sudo reboot
}