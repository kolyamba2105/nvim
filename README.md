# Neovim

- Install `packer`

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

- Install global `yarn` packages

```sh
yarn global add prettier
```

- Install language servers

```sh
yarn global add @prisma/language-server @tailwindcss/language-server bash-language-server typescript-language-server vscode-langservers-extracted yaml-language-server
```

- Install efm language server

```sh
brew install efm-langserver
```

```sh
# Without package manager
go install github.com/mattn/efm-langserver@latest
```
