## my custom functions and aliases for ~/.bashrc
## LeKilleRGallet 
##

#python related aliases
alias py='python3'
alias python='python3'
alias avenv='source venv/bin/activate'
alias ignorevenv="echo 'venv/' >> .gitignore"
alias requirements="pip freeze > requirements.txt"
alias piprequirements="pip install -r requirements.txt"

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
            if [[ lib == "requirements.txt" ]]; then
                pip install -r requirements.txt
            else
                pip install $lib
            fi
            # pygenesis 3.8.2 -numpy -pandas -requirements.txt
            #This command will create a virtual environment using Python 3.8.2, activate it,
            #install the numpy and pandas packages using pip, install any packages listed in the
            #requirements.txt file using pip, run the requirements command, and deactivate the virtual environment.
        fi
    done
    requirements
    deactivate
}

function addcommit() {
    git add .
    if [ -z "$1" ]; then
        git commit -m "Updated: $(date +'%d/%m/%Y')"
    elif [[ $1 == -m* ]]; then
        message=${1#-m}  # Remove the "-m" at the beginning
        message=$(echo "$message" | sed -e 's/^ *//;s/ *$//')  # Remove leading and trailing spaces
        if [[ $message == \"*\" || $message == \'*\' ]]; then
            git commit -m $message
        else
            echo "The message is not enclosed in quotes."
        fi
    fi
}



function gitgenesis() {
    git init
    git add .
    git commit -m"genesis"
}

function ignoretex() {
    echo '# Blacklist everything' >> .gitignore
    echo '*' >> .gitignore
    echo '# Whitelist all directories' >> .gitignore
    echo '!*/' >> .gitignore
    echo '# Whitelist the .tex and .pdf files' >> .gitignore
    echo '!*.tex' >> .gitignore
    echo '!*.pdf' >> .gitignore
}

function textemplate() {
    cp /home/$USER/Templates/LaTeX/main.tex .
    cp /home/$USER/Templates/LaTeX/references.bib .
    cp /home/$USER/Templates/LaTeX/UF_FRED_paper_style.sty .

    ignoretex

    echo '# Whitelist reference and style files' >> .gitignore
    echo '!references.bib' >> .gitignore
    echo '!UF_FRED_paper_style.sty' >> .gitignore
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
    message=''
    for arg in "$@"; do
        if [[ $arg == -m* ]]; then # If an argument starts with '-m', it is considered as the commit message.
            message=$arg
        fi
    done
    
    if [ -z "$1" ] || [[ "$1" == "-m"* ]]; then # If no argument is passed or the first argument is a commit message, commit and push to both 'university' and 'linuxshell' repositories.
        commitpush university $message
        commitpush linuxshell $message
    elif [[ "$1" == "university" ]]; then
        (cd ~/learning/university/; git diff --no-index --quiet tracked_file untracked_file && echo "No changes to commit in $(basename $(pwd))" || (addcommit $message; git push origin master))
    elif [[ "$1" == "linuxshell" ]]; then
        (cd /home/$USER ;sed -n '119,$p' ~/.bashrc > /home/$USER/learning/linuxshell/.bashrc) #validate both files are different before overwriting
        (cd ~/learning/linuxshell/; git diff --no-index --quiet tracked_file untracked_file && echo "No changes to commit in $(basename $(pwd))" || (addcommit $message; git push origin master --force))
    else
        echo -e "commitpush args: [university|linuxshell] for all use commitpush without arguments"
    fi
}