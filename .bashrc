## my custom functions and aliases for ~/.bashrc
## LeKilleRGallet
##


alias avenv='source venv/bin/activate'
alias ignorevenv="echo 'venv/' >> .gitignore"


alias py='python3'
alias python='python3'

alias bashrc="source ~/.bashrc"
alias code.bashrc="code ~/.bashrc"

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
    if [[ "$1" == "python" ]]; then
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
        echo "sketch [python|c|cpp|java|r]"
    fi
}
