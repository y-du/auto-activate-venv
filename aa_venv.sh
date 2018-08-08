#!/bin/bash

envs_dir=$HOME/.pyenv

function auto_activate_venv() {
    if [ -s ".venv" ]; then
        venv=$(head -n 1 .venv)
        if [ -n "$venv" ]; then
            if [ -d $envs_dir/$venv ]; then
                venv_path=$envs_dir/$venv
                if [ "$VIRTUAL_ENV" != "$venv_path" ]; then
                    venv_name=$(basename $venv_path)
                    clear
                    echo "activating venv '$venv_name' ..."
                    source $venv_path/bin/activate
                fi
            fi
        fi
    fi
}

export PROMPT_COMMAND=auto_activate_venv