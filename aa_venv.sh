#!/bin/bash

envs_dir=$HOME/.pyenv

l_blue='\033[1;34m'
white='\033[0m'

function cd {
    builtin cd "$@"
    if [ -s ".venv" ]; then
        venv=$(head -n 1 .venv)
        if [ -n "$venv" ]; then
            if [ -d $envs_dir/$venv ]; then
                venv_path=$envs_dir/$venv
                if [ "$VIRTUAL_ENV" != "$venv_path" ]; then
                    venv_name=$(basename $venv_path)
                    clear
                    echo -e "${l_blue}activating '$venv_name' venv ...${white}"
                    source $venv_path/bin/activate
                fi
            fi
        fi
    fi
}

#export PROMPT_COMMAND="_auto_activate_venv; $PROMPT_COMMAND"