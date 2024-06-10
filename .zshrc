if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode disabled #auto      # update automatically without asking
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="%d/%m/%y T"
ZSH_CUSTOM="$HOME/.dotfiles"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fast-syntax-highlighting
	aws
	gcloud
	kubectl
	docker
        azure
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Prefefred editor for local and remote sessions
EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs='git status'
alias gp='git pull'
alias gl='git log --pretty=format:"%h %s" --graph'
gmp() {
	git add -A && git commit -m $@ && git push;
}
alias gu='git submodule update --recursive --remote'

export EDITOR=nvim
export K9S_EDITOR=nvim

# Ruest
PATH="/opt/homebrew/opt/curl/bin:$PATH:$HOME/CliApps:$HOME/go/bin:/opt/homebrew/opt/libpq/bin:$HOME/.cargo/bin"

# OpenTofu
alias tp='tofu fmt && tofu plan -parallelism=12'
alias ta='tofu fmt && tofu apply -parallelism=12'

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
twitch-dl() {
	docker run -it --rm \
                --workdir '/tmp' \
                -v $PWD:/tmp \
                kannie/twitch-dl:latest \
                $@

}
gssh-zone() { gcloud compute ssh --zone $2 $3 --tunnel-through-iap --project $1; }
gssha() { gssh-zone $1 "asia-southeast1-a" $2; }
gsshb() { gssh-zone $1 "asia-southeast1-b" $2; }
gsshc() { gssh-zone $1 "asia-southeast1-c" $2; }

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Gitlab
export NODE_OPTIONS="--no-node-snapshot"
export TF_HTTP_USERNAME=kantapon.p
export TF_HTTP_PASSWORD=glpat-whzdgUuyTF_dfPZgq2aM


# Google Cloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/CliApps/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc"; fi

# Increase the IAP TCP upload bandwidth
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Add Kube Configs
export KUBECONFIG=~/.kube/config:$(find ~/.kube -type f -name '*.yaml' | tr '\n' ':')

# direnv
eval "$(direnv hook zsh)"
