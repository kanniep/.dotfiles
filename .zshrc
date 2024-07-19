if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode disabled

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="%d/%m/%y T"
ZSH_CUSTOM="$HOME/.dotfiles"

# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt SHARE_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS


plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
	fast-syntax-highlighting
	# git
	# aws
	# gcloud
	# kubectl
	# docker
	# azure
)
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Prefefred editor for local and remote sessions
export EDITOR='nvim'
export K9S_EDITOR='nvim'

# Path
PATH="/opt/homebrew/opt/curl/bin:$PATH:$HOME/CliApps:$HOME/go/bin:/opt/homebrew/opt/libpq/bin:$HOME/.cargo/bin"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Example aliases
alias gs='git status'
alias gp='git pull'
alias gl='git log --pretty=format:"%h %s" --graph'
gmp() {
	git add -A && git commit -m $@ && git push;
}
alias gu='git submodule update --recursive --remote'

# OpenTofu
alias tp='tofu fmt && tofu plan -parallelism=12 -out=tfplan'
alias ta='tofu apply -parallelism=12 tfplan && rm tfplan'

# Docker Alias
alias db='docker system prune -f && docker compose build'
alias dup='docker compose up'
alias dupp='docker compose up -d'
alias dd='docker compose down'
# Go Lang
export GOPATH=$HOME/go

# Psql
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"

# Custom Functions
gssh-zone() { gcloud compute ssh --zone $2 $3 --tunnel-through-iap --project $1; }
gssha() { gssh-zone $1 "asia-southeast1-a" $2; }
gsshb() { gssh-zone $1 "asia-southeast1-b" $2; }
gsshc() { gssh-zone $1 "asia-southeast1-c" $2; }

# NVM
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export NODE_OPTIONS="--no-node-snapshot"

# Google Cloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/CliApps/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc"; fi

# Increase the IAP TCP upload bandwidth
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Add Kube Configs
alias k=kubectl
# export KUBECONFIG=~/.kube/config:$(find ~/.kube -type f -name '*.yaml' | tr '\n' ':')

# OpenVPN
alias ovpn='/Applications/OpenVPN\ Connect/OpenVPN\ Connect.app/contents/MacOS/OpenVPN\ Connect'
ovpnr() { ovpn --remove-profile=admin && ovpn --import-profile='/Users/a667356/Workspace/arise-ccoe/ovpn-admin-config/KTB Cloud VPN Admin.ovpn' --name=admin --username=kantapon.p@arise.tech }

# END OF FILE EVAL
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh