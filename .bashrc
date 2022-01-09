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

#bashrc related aliases
alias bashrc="source ~/.bashrc"
alias code.bashrc="code ~/.bashrc"

#       FUNCTIONS
function pygenesis() {
    if [ -z "$1" ]; then
        python -m venv venv
    else
        python$1 -m venv venv
    fi
    ignorevenv
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
        code /home/lekillergallet/learning/sketchbook/Sketch.py
    elif [[ "$1" == "c" ]]; then
        code /home/lekillergallet/learning/sketchbook/Sketch.c
    elif [[ "$1" == "cpp" ]]; then
        code /home/lekillergallet/learning/sketchbook/Sketch.cpp
    elif [[ "$1" == "java" ]]; then
        code /home/lekillergallet/learning/sketchbook/Sketch.java
    elif [[ "$1" == "r" ]]; then
        code /home/lekillergallet/learning/sketchbook/Sketch.r
    elif [[ "$1" == "commit" ]]; then
        (cd ~/learning/sketchbook/; gitcommitdate)
    else
        echo -e "sketch [py|c|cpp|java|r]"
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
        sed -n '119,$p' .bashrc > /home/lekillergallet/learning/linuxshell/.bashrc #validate both files are different before overwriting
        (cd ~/learning/linuxshell/; gitcommitdate)
        (cd ~/learning/linuxshell/; git push origin master) ##
    #validate need commit for proyects and all
    else
        echo -e "commitpush [sketch|platzi|university|linuxshell] \n soon: proyects & all"
    fi
}

function wifianx() { #just for realtek 8821CU drivers, note: idk but when i upgrade kernel i need to reinstall wifi drivers
    cd ~/build/rtl8821CU
    sudo make uninstall
    cd ..
    rm -rf rtl8821CU/
    git clone https://github.com/brektrou/rtl8821CU.git
    cd ~/build/rtl8821CU
    make
    sudo make install
}
















