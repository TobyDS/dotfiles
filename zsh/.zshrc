# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Optionally, uncomment to integrate with iTerm2, if installed.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Oh-My-Zsh installation path
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Homebrew paths for Intel-based and Apple Silicon Macs
[ -d "/usr/local/bin" ] && export PATH="/usr/local/bin:$PATH"
[ -d "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"
# Additional Homebrew sbin directories
[ -d "/usr/local/sbin" ] && export PATH="/usr/local/sbin:$PATH"
[ -d "/opt/homebrew/sbin" ] && export PATH="/opt/homebrew/sbin:$PATH"
# Dynamically add Python user base binary directory to PATH
python_user_base=$(python3 -m site --user-base 2>/dev/null)
if [[ -d "${python_user_base}/bin" ]]; then
    export PATH="${python_user_base}/bin:${PATH}"
fi
# Source bash-wakatime
# if [ -f "$HOME/bash-wakatime/bash-wakatime.sh" ]; then
#     source "$HOME/bash-wakatime/bash-wakatime.sh"
# else
#     echo "bash-wakatime.sh not found, please check the path."
# fi

unset ZSH_AUTOSUGGEST_USE_ASYNC


# Plugins
plugins=(zsh-nvm git sudo macos copyfile you-should-use iterm2 zsh-bat copypath web-search zsh-wakatime zsh-autocomplete zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ngrok="./ngrok"
alias vim="nvim"
alias vi="nvim"
alias rvim="vim"
alias rvi="vi"
alias sf="stow -R /*"
alias tmux="tmux -u"
# oh-my-zsh config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)

# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
zstyle ':completion:*' menu select
zstyle ':autocomplete:*' list-lines 7
zstyle ':completion:*:default' list-colors \
  "di=1;34"

bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey '\e[A' history-beginning-search-backward
bindkey '^H' backward-kill-word

export LS_COLORS=ExfxbEaEBxxEhEhBaDaCaD;
export LSCOLORS=ExfxbEaEBxxEhEhBaDaCaD;
export BAT_THEME="night-owlish"

# Attempt to dynamically find the Conda install location and initialize
if [ -z "$CONDA_PREFIX" ]; then
    # List of common Conda installation paths to check
    CONDA_LOCATIONS=("$HOME/miniconda3" "$HOME/anaconda3" "/usr/local/miniconda3" "/usr/local/anaconda3")

    for loc in "${CONDA_LOCATIONS[@]}"; do
        if [ -d "$loc" ]; then
            export CONDA_PREFIX="$loc"
            break
        fi
    done
fi

if [ -n "$CONDA_PREFIX" ]; then
    export PATH="$CONDA_PREFIX/bin:$PATH"
    # Source the Conda configuration script if it exists
    [[ -f "$CONDA_PREFIX/etc/profile.d/conda.sh" ]] && source "$CONDA_PREFIX/etc/profile.d/conda.sh"
    # Optionally initialize Conda
    type conda >/dev/null 2>&1 && conda activate
fi
