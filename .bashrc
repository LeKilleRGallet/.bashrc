alias avenv='source venv/bin/activate'
alias ignorevenv="echo 'venv/' >> .gitignore"


alias py='python3'
alias python='python3'

alias bashrc="source ~/.bashrc"

alias gitcommitdate="git commit -m 'Updated: `date +'%d/%m/%Y'`'"

function pygenesis() {
    if [ -z "$1" ]; then
        python -m venv venv
    else
        python$1 -m venv venv
    fi
    ignorevenv
}

function gitgenesis() {
    git init
    git add .
    git commit -m"genesis"
}
