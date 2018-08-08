#!/bin/bash

envs_dir=$HOME/.pyenv

l_blue='\033[1;34m'
green='\033[0;32m'
white='\033[0m'

function venv_prompt(){
    if [ -n "$VIRTUAL_ENV" ]; then
        venv_name="$(basename $VIRTUAL_ENV)"
        echo -e "(${l_blue}$venv_name${white}) "
    else
        echo ""
    fi
}

function cd {
    builtin cd "$@"
    if [ $? -eq 0 ]; then
        if [ -s ".venv" ]; then
            venv=$(head -n 1 .venv)
            if [ -n "$venv" ]; then
                if [ -d $envs_dir/$venv ]; then
                    venv_path=$envs_dir/$venv
                    if [ "$VIRTUAL_ENV" != "$venv_path" ]; then
                        venv_name=$(basename $venv_path)
                        echo -e "${green}activating '$venv_name' venv ...${white}"
                        source $venv_path/bin/activate
                    fi
                fi
            fi
        fi
    fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PS1="\$(venv_prompt)$PS1"