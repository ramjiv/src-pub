#!/bin/bash
if [ ! -x /usr/local/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

PATH=/bin:/usr/bin:/usr/local/bin:/usr/sbin:/sbin:$HOME/bin:$HOME/.local/bin
export PATH

## homebrew
brew install golang wget awscli firebase-cli git jq mutt neovim openjdk powerline-go python starship 
brew install procs sd dust tokei clementtsang/bottom/bottom tealdeer bandwhich grex svn vim jsonlint node npm exa fzf
brew install tmux youtube-dl direnv jump autoenv bat ripgrep fd diskus hexyl insect rmlint

# OMFG - bat is lifechanging
# https://github.com/sharkdp/bat

brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font font-fira-code-nerd-font font-fira-mono-nerd-font font-jetbrains-mono-nerd-font 
brew cask install font-inconsolata-go-nerd-font font-fira-sans-extra-condensed font-code-new-roman-nerd-font
brew cask install iterm2
