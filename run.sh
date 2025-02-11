#!/bin/bash

export HOME="/workspace"
LOCALE="${LOCALE:-en}"
PASSWORD="${PASSWORD:-changeit}"
EXTENSIONS="${EXTENSIONS:-golang.go|ms-python.python|ms-python.debugpy|eamodio.gitlens|humao.rest-client|esbenp.prettier-vscode|dbaeumer.vscode-eslint|ecmel.vscode-html-css|pkief.material-icon-theme|k--kato.intellij-idea-keybindings}"

dnf update -y

/app/code-server/bin/code-server --install-extension ${EXTENSIONS//|/ --install-extension }
/app/code-server/bin/code-server --disable-telemetry --disable-workspace-trust --locale ${LOCALE} --bind-addr 0.0.0.0:8080