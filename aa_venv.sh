#!/bin/bash

#   Copyright 2018 Yann Dumont
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

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

#export VIRTUAL_ENV_DISABLE_PROMPT=1
#export PS1="\$(venv_prompt)$PS1"
