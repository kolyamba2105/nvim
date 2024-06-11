# Neovim

## Homebrew

```sh
# Pin (freeze) neovim formula
brew pin neovim

# List pinned formulas
brew list --pinned

# Manual update should work as epxected
brew upgarde neovim
```

## Install tools and language servers

```sh
npm i -g @prisma/language-server @tailwindcss/language-server bash-language-server cssmodules-language-server graphql-language-service-cli prettier serve typescript vscode-langservers-extracted yaml-language-server
```

## Install efm language server

```sh
brew install efm-langserver

# Without package manager
go install github.com/mattn/efm-langserver@latest
```
