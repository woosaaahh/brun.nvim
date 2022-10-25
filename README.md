- [Requirements](#requirements)
- [Usage](#usage)
- [Configuration](#configuration)

# BRun

BRun helps to run commands after saving a file and and see the result in a buffer.

This project was inspired by [@TjDeVries](https://github.com/tjdevries) and his Youtube
video [here](https://www.youtube.com/watch?v=HlfjpstqXwE).

## Requirements

To use this plugin, you need :

- to have [Neovim](https://github.com/neovim/neovim)
  [`0.8+`](https://github.com/neovim/neovim/releases) version installed ;
- to add `woosaaahh/brun.nvim` in your plugin manager configuration ;
- to add [`ThePrimeagen/harpoon`](https://github.com/ThePrimeagen/harpoon) in your plugin
  manager configuration.

Here are some plugin managers :

- [vim-plug](https://github.com/junegunn/vim-plug) ;
- [packer.nvim](https://github.com/wbthomason/packer.nvim) ;
- [paq-nvim](https://github.com/savq/paq-nvim).

## Usage

- Add `require("brun.nvim").setup()` in your configuration ;
- Run `:BRun` or `:BRun harpoon` ;
- Fill in each prompts.

## Configuration

No configuration needed !
