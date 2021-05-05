# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
HISTFILE=~/.zsh_history

HISTSIZE=10000

SAVEHIST=10000

setopt appendhistory

# Activate vi mode and set some shortcuts
bindkey -v
export EDITOR='vim'

# ALIAS
alias reshim="asdf reshim nodejs && asdf reshim ruby && asdf reshim python"
# Git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git checkout"
alias gd="git diff --color"
alias gcd="git checkout --"
alias grр="git reset HEAD"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold yellow)<%an>%Creset' --abbrev-commit --"
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias glist='for ref in $(git for-each-ref --sort=-committerdate --count=50 --format="%(refname)" refs/heads/ refs/remotes ); do git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat ; done | awk '"'! a["'$0'"]++'"


#Install ASDF
#if [[ ! -d "/${HOME}/.zinit/bin" ]]; then
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
#fi
#if [[ ! -d "/${HOME}/.asdf" ]]; then
#	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
#    autoload -Uz compinit && compinit
#    . $HOME/.asdf/asdf.sh
#    asdf update
#    asdf plugin-add nodejs
#    asdf plugin-add ruby
#    asdf plugin-add python
#    asdf install nodejs latest
#    asdf install ruby latest
#    asdf install python latest
#    asdf global nodejs latest
#    asdf global ruby latest
#    asdf global python latest
#fi

#ZINIT SETUP


zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit ice wait"0" if'[[ -n "$commands[fuck]" ]]' lucid

zinit snippet OMZ::plugins/thefuck/thefuck.plugin.zsh

zinit wait lucid for \
    OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    OMZ::plugins/dirhistory/dirhistory.plugin.zsh \
    OMZ::plugins/docker-compose/docker-compose.plugin.zsh \
    OMZ::plugins/git/git.plugin.zsh \

# You-Should-Use
#
# Plugin that reminds you to use your aliases. Will notify you 
# if there is an alias for some command that you use. 
#
# Website: https://github.com/MichaelAquilina/zsh-you-should-use
zinit ice pick"you-should-use.plugin.zsh"; zinit load "MichaelAquilina/zsh-you-should-use"


zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/sbin:$PATH"
. $HOME/.asdf/asdf.sh
