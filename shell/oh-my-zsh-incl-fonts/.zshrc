# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerline"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# Powerline theme customs
#By default, at the right of the powerline are displayed the date and the time. If you don't want date or time, you can choose what you want to display:
# Date
POWERLINE_RIGHT_A=`date "+%y-%m-%d"`
# Time
POWERLINE_RIGHT_B=`date "+%H:%M"`

POWERLINE_NO_BLANK_LINE="true"
# POWERLINE_FULL_CURRENT_PATH="false"

#If you want git info on right instead of left:
POWERLINE_SHOW_GIT_ON_RIGHT="true"

#If you want svn info on right instead of left:
POWERLINE_SHOW_SVN_ON_RIGHT="true"

#If you want to tell if you are in a remote SSH session:
POWERLINE_DETECT_SSH="true"

plugins=(git git-extras svn autojump sublime debian)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export JAVA_HOME=/opt/java7

