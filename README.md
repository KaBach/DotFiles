# DotFiles

My .files. Everything can be installed through the install.sh script which calls stow to link all packages, stow is included in the repo (just a perl script).

Note:
For issue with node on the HPC use nvm to manage versions.. And don't install yarn, you can use npm to install coc-nvim

# Neovim setup
A lot is copied from the quarto-nvim setup right now. It requires the additional external dependencies for the telescope app:
https://github.com/sharkdp/fd
https://github.com/BurntSushi/ripgrep

Also requires pyright for the lsp, not.. You're installlinng all of them through mason
