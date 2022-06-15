# -------------------------------------------------------------------------- zsh
# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dsiebel"

# disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

#  display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${HOME}/.zsh-custom"

# -------------------------------------------------------------------------- env

# Setup homebrew env vars
# Note: PATH will be overwritten later
if [[ "$(/usr/bin/arch)" == "i386" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
else
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export HOMEBREW_PREFIX_X86="$(/usr/local/bin/brew --prefix)"
export HOMEBREW_PREFIX_ARM64="$(/opt/homebrew/bin/brew --prefix)"

# configure XDEBUG support
# export XDEBUG_CONFIG="idekey=XDEBUG";

# use vim as default editor for everything
export EDITOR="/usr/bin/vim";
export GIT_EDITOR=$EDITOR;
export SVN_EDITOR=$EDITOR;

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Prefer US English and use UTF-8
export LC_ALL='en_US.UTF-8';
export LANG='en_US.UTF-8';
export LC_LANG='en_US.UTF-8';

# Highlight section titles in man pages
export LESS_TERMCAP_md="${yellow}";

# Don't clear screen after quitting man page
export MANPAGER='less -X';
# export MANPATH="/usr/local/man:$MANPATH"

# setup java properly. Thanks, Steve!
export JAVA_HOME="$(/usr/libexec/java_home)";

# Golang $GOPATH. Do the kids still do it like this nowadays?
export GOPATH="${HOME}/workspace/source/Go"

# check for nvm and load it if present
#export NVM_DIR="/Users/dsiebel/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GRADLE_USER_HOME="${HOME}/.gradle"

export GPG_TTY="$(tty)"

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# https://krew.sigs.k8s.io/docs/user-guide/advanced-configuration/
# used in `.path`
export KREW_ROOT="${HOME}/.krew"
