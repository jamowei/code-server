#!/bin/bash

# set defaults for env vars
export HOME="/workspace"
LOCALE="${LOCALE:-en}"
PASSWORD="${PASSWORD:-changeit}"
EXTENSIONS="${EXTENSIONS:-golang.go|ms-python.python|ms-python.debugpy|eamodio.gitlens|humao.rest-client|esbenp.prettier-vscode|dbaeumer.vscode-eslint|ecmel.vscode-html-css|pkief.material-icon-theme}"

# update system
dnf update -y

# create .bashrc
cat > /workspace/.bashrc << EOL
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
unset rc

alias cd..='cd ..'

function parse_git_dirty {
  [[ \$(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1\$(parse_git_dirty))/"
}
export PS1="\t \[\033[32m\]\w\[\033[33m\]\\\$(parse_git_branch)\[\033[00m\] \$ "
EOL

# install vs-code extensions
/app/code-server/bin/code-server --install-extension ${EXTENSIONS//|/ --install-extension }
# run code-server
/app/code-server/bin/code-server --disable-telemetry --disable-workspace-trust --locale ${LOCALE} --bind-addr 0.0.0.0:8080