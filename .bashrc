export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible/vault

alias ssh='kitten ssh'
alias ls='ls --color=auto'
alias dc='docker compose'

dce() {
	devcontainer exec --workspace-folder . "$@"
}
export PATH="$HOME/.local/bin:$PATH"
