# services
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
eval "$(starship init zsh)"

# plugins
ZPLUGINDIR=$HOME/.zsh/plugins
[[ ! -d $ZPLUGINDIR/zsh-autosuggestions ]] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZPLUGINDIR/zsh-autosuggestions; source $ZPLUGINDIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
[[ ! -d $ZPLUGINDIR/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting/ $ZPLUGINDIR/zsh-syntax-highlighting; source $ZPLUGINDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# options
setopt auto_cd
setopt auto_pushd
export EDITOR='vim'

# binds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept
bindkey -e

# aliases
alias ls='eza --icons=auto'
alias l='ls -lah'
alias ll='ls -lh'
alias lt='ls -lhtr'
alias grep='rg --color'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
HISTTIMEFORMAT="%F %T"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
