if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="%d/%m/%y T"
ZSH_CUSTOM="$HOME/.dotfiles"

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
# export LANG=en_US.UTF-8

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/CliApps/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/CliApps/google-cloud-sdk/completion.zsh.inc"; fi

# Increase the IAP TCP upload bandwidth
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Add Kube Configs
export KUBECONFIG=~/.kube/config:$(find ~/.kube -type f -name '*.yaml' | tr '\n' ':')

export EDITOR=nvim
export K9S_EDITOR=nvim

PATH="$PATH:$HOME/CliApps:$HOME/go/bin:/opt/homebrew/opt/libpq/bin:$HOME/.cargo/bin"

# OpenTofu
alias tp='tofu plan -parallelism=32'
alias ta='tofu apply -parallelism=32'

# Go Lang
export GOPATH=$HOME/go
godoc() {
        docker run -it --rm \
                --workdir '/app' \
                -v $PWD:/app \
                -v $HOME/go:/go \
                golang:1.21-alpine \
                go $@
}
gorun() {
        docker run -it --rm \
                -v $PWD:/app \
                -v $HOME/go:/go \
                -v $HOME/.config/gcloud/application_default_credentials.json:/root/.config/gcloud/application_default_credentials.json:ro \
                golang:1.21-alpine \
                $@
}

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

# Backstage
export NODE_OPTIONS="--no-node-snapshot"
export TF_HTTP_USERNAME=kantapon.p
export TF_HTTP_PASSWORD=glpat-whzdgUuyTF_dfPZgq2aM
