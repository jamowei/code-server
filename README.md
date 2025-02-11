# code-server docker

[![Build and Release](https://github.com/jamowei/code-server/actions/workflows/buildAndRelease.yaml/badge.svg)](https://github.com/jamowei/code-server/actions/workflows/buildAndRelease.yaml)

Run [VS Code](https://github.com/Microsoft/vscode) on
any [Docker](https://www.docker.com/) host and use it in the browser.

The Docker image is based on latest [Fedora Linux](https://hub.docker.com/_/fedora) image
and starts the great [code-server](https://github.com/coder/code-server) inside.

## Run it

```
docker run --rm --name code-server \
 -p 8080:8080 \
 -e PASSWORD=mypassword \
 -v /my/workspace:/workspace \
 ghcr.io/jamowei/code-server:latest
```

Then open http://localhost:8080/

## Environment Variables

| Name       | Default Value                                                                                                                                                                                                             | Description                                                                                                               |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| LOCALE     | `en`                                                                                                                                                                                                                      | Set the locale of vs-code. See available [here](https://code.visualstudio.com/docs/getstarted/locales#_available-locales) |
| PASSWORD   | `changeit`                                                                                                                                                                                                                | Password for using code-server                                                                                            |
| EXTENSIONS | `golang.go\|ms-python.python\|ms-python.debugpy\|eamodio.gitlens\|humao.rest-client\|esbenp.prettier-vscode\|dbaeumer.vscode-eslint\|ecmel.vscode-html-css\|pkief.material-icon-theme\|k--kato.intellij-idea-keybindings` | List of vs-code extensions-ids, separated by `\|`                                                                         |

## Build it

Get the latest released `VERSION` of [code-server](https://github.com/coder/code-server)
from [here](https://github.com/coder/code-server/releases).
```
docker build --build-arg VERSION=v4.96.4 -t myrepo/code-server:v1.0 .
```