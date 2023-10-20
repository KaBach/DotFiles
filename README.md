# DotFiles

My .files. Everything can be installed through the install.sh script which calls stow to link all packages, stow is included in the repo (just a perl script).

Note:
For issue with node on the HPC use nvm to manage versions.. And don't install yarn, you can use npm to install coc-nvim

# Neovim setup
A lot is copied from the quarto-nvim setup right now. It requires the additional external dependencies for the telescope app:
https://github.com/sharkdp/fd
https://github.com/BurntSushi/ripgrep

# Stow
Installation straight forward on personal (root) machine, for non-root system see:
https://www.gnu.org/software/stow/manual/html_node/Compile_002dtime-vs-Install_002dtime.html#Compile_002dtime-vs-Install_002dtime
Some software packages allow you to specify, at compile-time, separate locations for installation and for run-time. Perl is one such package; see Perl and Perl 5 Modules. Others allow you to compile the package, then give a different destination in the ‘make install’ step without causing the binaries or other files to get rebuilt. Most GNU software falls into this category; Emacs is a notable exception. See GNU Emacs, and Other FSF Software.

Still other software packages cannot abide the idea of separate installation and run-time locations at all. If you try to ‘make install prefix=/usr/local/stow/foo’, then first the whole package will be recompiled to hardwire the /usr/local/stow/foo path. With these packages, it is best to compile normally, then run ‘make -n install’, which should report all the steps needed to install the just-built software. Place this output into a file, edit the commands in the file to remove recompilation steps and to reflect the Stow-based installation location, and execute the edited file as a shell script in place of ‘make install’. Be sure to execute the script using the same shell that ‘make install’ would have used.

Pyright is being installed through mason

You further need to set
-- $home/.config/marksman/config.toml :
-- [core]
-- markdown.file_extensions = ["md", "markdown", "qmd"]
