# DotFiles

My .files. Everything can be installed through the install.sh script which calls stow to link all packages, stow is included in the repo (just a perl script).

Note:
For issue with node on the HPC use nvm to manage versions.. And don't install yarn, you can use npm to install coc-nvim

# Neovim setup
A lot is copied from the quarto-nvim setup right now. It requires the additional external dependencies for the telescope app:
https://github.com/sharkdp/fd
https://github.com/BurntSushi/ripgrep

# TMUX setup
Recently changed to tpm for plugin management (might get deprecated, yai). Needs separate [installation](https://github.com/tmux-plugins/tpm)

# Stow
Installation straight forward on personal (root) machine, for non-root system see:

https://www.gnu.org/software/stow/manual/html_node/Compile_002dtime-vs-Install_002dtime.html#Compile_002dtime-vs-Install_002dtime
- Download release version
- ./configure --prefix=PREFIX & make -n install > script.sh
- make changes to script.sh as suggested in the link (change enter and leaving directories)
- add PREFIX/share/Perl5/ to the PERl5LIB ENV variable

Pyright is being installed through mason

You further need to set
-- $home/.config/marksman/config.toml :
-- [core]
-- markdown.file_extensions = ["md", "markdown", "qmd"]
